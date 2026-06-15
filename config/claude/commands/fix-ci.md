---
description: Find CircleCI failures for current branch's PR and attempt to fix them
allowed-tools: Bash(git:*), Bash(bundle exec rspec:*), Bash(bundle exec rubocop:*), Read, Edit, Glob, Grep, mcp__github__*, mcp__circleci-mcp-server__*
---

# Fix CircleCI Failures

## Current Context

- Current branch: !`git branch --show-current`

## Your Task

Investigate CircleCI failures for the current branch's PR and attempt to fix them.

Use the GitHub MCP server tools for all GitHub interactions instead of the `gh` CLI.

### Step 1: Find the PR for Current Branch

Use `get_me` to get the current user, then use `search_pull_requests` to find the PR:

```
search_pull_requests(query: "head:{current_branch} state:open")
```

If no PR exists, inform the user and stop.

### Step 2: Get CircleCI Status from PR

Use `pull_request_read(method: "get_status")` to get the CI check details. Look for failed checks with "circleci" in the name or URL.

### Step 3: Get Failure Details via the CircleCI MCP Server

Use the **CircleCI MCP server** (`mcp__circleci-mcp-server__*`) for all CircleCI interactions. Do NOT shell out to `curl` against the CircleCI REST API, and do NOT rely on a `CIRCLE_CI_API_TOKEN` env var; the MCP server holds its own auth.

The failed check from Step 2 has a `target_url` / `details_url` pointing at CircleCI (a pipeline, workflow, or job URL). Pass that URL straight to the MCP tools:

**Get the failure logs (primary tool):**

```
mcp__circleci-mcp-server__get_build_failure_logs(params: {
  projectURL: "<the CircleCI URL from the failed GitHub check>"
})
```

This returns the failing job's log output, including the RSpec failure block, Rubocop offenses, or build error. Notes:
- The log can be large and is truncated inline; if you see a `<MCPTruncationWarning>`, either pass `outputDir` (e.g. the repo root) to write the full log to a file, or narrow down from the truncated tail, which usually already contains the `Failures:` / `Failed examples:` section.
- If you only have a project slug and branch instead of a URL, call it with `params: { projectSlug: "gh/{org}/{repo}", branch: "{branch}" }` instead.

**Check overall pipeline status (optional):**

```
mcp__circleci-mcp-server__get_latest_pipeline_status(params: {
  projectURL: "<CircleCI URL>"
})
```

Other useful tools in the same server: `get_job_test_results` (structured test failures), `get_build_failure_logs` per workflow, and `find_flaky_tests`. Search for `mcp__circleci-mcp-server__*` to see the full set.

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
