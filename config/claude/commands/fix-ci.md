---
description: Find CircleCI failures for current branch's PR and attempt to fix them
allowed-tools: Bash(gh:*), Bash(git:*), Bash(curl:*), Bash(bundle exec rspec:*), Bash(bundle exec rubocop:*), Read, Edit, Glob, Grep
---

# Fix CircleCI Failures

## Current Context

- Current branch: !`git branch --show-current`
- Repository: !`gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "unknown"`

## Your Task

Investigate CircleCI failures for the current branch's PR and attempt to fix them.

### Step 1: Find the PR for Current Branch

```bash
gh pr list --head "$(git branch --show-current)" --json number,url,statusCheckRollup --limit 1
```

If no PR exists, inform the user and stop.

### Step 2: Get CircleCI Status from PR

Extract the CircleCI check details from the PR's status checks. Look for failed checks with "circleci" in the name or URL.

### Step 3: Query CircleCI API for Failure Details

**Authentication:** Use the `CIRCLE_CI_API_TOKEN` environment variable with Basic auth:

```bash
curl -s --header "authorization: Basic $(echo -n "$CIRCLE_CI_API_TOKEN:" | base64)" \
  "https://circleci.com/api/v2/..."
```

**Get the latest pipeline for the branch:**

```bash
curl -s --header "authorization: Basic $(echo -n "$CIRCLE_CI_API_TOKEN:" | base64)" \
  "https://circleci.com/api/v2/project/gh/{org}/{repo}/pipeline?branch={branch}" | jq '.items[0]'
```

**Get workflows from the pipeline:**

```bash
curl -s --header "authorization: Basic $(echo -n "$CIRCLE_CI_API_TOKEN:" | base64)" \
  "https://circleci.com/api/v2/pipeline/{pipeline_id}/workflow" | jq '.items'
```

**Get jobs from failed workflow:**

```bash
curl -s --header "authorization: Basic $(echo -n "$CIRCLE_CI_API_TOKEN:" | base64)" \
  "https://circleci.com/api/v2/workflow/{workflow_id}/job" | jq '.items[] | select(.status == "failed")'
```

**Get detailed job info including steps (use v1.1 API):**

```bash
curl -s --header "authorization: Basic $(echo -n "$CIRCLE_CI_API_TOKEN:" | base64)" \
  "https://circleci.com/api/v1.1/project/github/{org}/{repo}/{job_number}" | jq '.steps[] | select(.actions[0].status == "failed")'
```

**Get the actual failure output:**

The failed step will have an `output_url` in its action. Fetch it directly (no auth needed - it's a presigned URL):

```bash
curl -s "{output_url}" | jq -r '.[] | .message'
```

### Step 4: Analyze and Report Failures

Present a clear summary of what failed:

```
🔴 CIRCLECI FAILURE REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 PR: #{number} - {title}
🔗 CircleCI: {workflow_url}

❌ Failed Job: {job_name}
   Step: {step_name}

📝 Error Summary:
   {concise description of what went wrong}

📄 Key Error Output:
   {relevant portion of the error output}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Step 5: Categorize the Failure

Determine the type of failure:

1. **RSpec Test Failure** - A spec is failing
2. **Rubocop Violation** - Code style issues
3. **Build/Compilation Error** - Syntax errors, missing dependencies
4. **Database Error** - Migration or schema issues
5. **Environment/Config Error** - Missing env vars, config issues
6. **Timeout** - Job took too long
7. **Infrastructure Error** - Docker, caching, or CI config issues

### Step 6: Attempt Auto-Fix Based on Failure Type

**For RSpec failures:**
1. Identify the failing spec file and line number
2. Read the spec and related application code
3. Understand what the test expects vs what happened
4. Fix the issue in the application code (prefer this) or fix the test if it's incorrect

**For Rubocop violations:**
1. Identify the files with violations
2. Run `bundle exec rubocop -a {files}` to auto-fix
3. If violations remain, run `bundle exec rubocop -A {files}` for unsafe fixes
4. Manually fix any remaining issues

**For Build/Syntax errors:**
1. Identify the file and line with the error
2. Read the file and fix the syntax issue

**For Environment/Config errors:**
1. Explain what's missing or misconfigured
2. Suggest how to fix it (may require manual intervention)

**For Infrastructure errors:**
1. Explain the issue
2. These often can't be auto-fixed - explain what manual steps are needed

### Step 7: Verify Fix Locally

After making fixes, verify locally:

```bash
# For spec failures
bundle exec rspec {failing_spec_files}

# For rubocop
bundle exec rubocop {fixed_files}
```

### Step 8: Present Results

```
✅ FIX SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔧 Changes Made:
   • {file1}: {description of change}
   • {file2}: {description of change}

🧪 Local Verification:
   • Specs: {pass/fail}
   • Rubocop: {pass/fail}

📝 Next Steps:
   {If fixed: "Commit these changes and push to trigger a new CI run"}
   {If not fixed: "Manual intervention required: {explanation}"}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Important Notes

- Always read the full error output before attempting fixes
- If the failure is clearly an infrastructure/CI issue (not code), explain this instead of trying to fix code
- Don't modify code unnecessarily - only fix what's actually broken
- If you can't determine the cause, ask the user for guidance
- Some failures (like flaky tests or timeout issues) may need to be re-run rather than fixed
