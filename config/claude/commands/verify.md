---
description: Verify changes by running affected specs and Rubocop
allowed-tools: Bash(git:*), Bash(bundle exec rspec:*), Bash(bundle exec rubocop:*)
---

# Verify Changes Against Develop

## Current Git State

- Current branch: !`git branch --show-current`
- Changed files: !`git diff --name-only develop...HEAD`
- Develop base commit: !`git merge-base develop HEAD`

## Your Task

Verify that all changes are working correctly and follow code standards by running tests and linters.

### Step 1: Identify Changed Files

Get the list of all files that have been added or modified compared to develop:

```bash
git diff --name-only develop...HEAD
```

### Step 2: Determine Affected Spec Files

For each changed file, identify which spec files need to be run:

**Mapping Rules:**
- If a spec file itself changed → run it directly
- If `app/models/foo.rb` changed → run `spec/models/foo_spec.rb`
- If `app/services/bar.rb` changed → run `spec/services/bar_spec.rb`
- If `app/controllers/baz_controller.rb` changed → run `spec/requests/**/*` or `spec/controllers/baz_controller_spec.rb`
- If `app/adapters/namespace/adapter.rb` changed → run `spec/adapters/namespace/adapter_spec.rb`
- If `app/entities/entity.rb` changed → run `spec/entities/entity_spec.rb`
- Apply similar logic for other directories (jobs, mailers, helpers, etc.)

**Build the list of spec files to run:**
- Collect all spec files that were directly changed
- Add corresponding spec files for changed application code (even if specs didn't change)
- Only include specs that actually exist (check with `ls` or `test -f`)
- If no specs are found, note this in the summary

### Step 3: Run Specs

If spec files were identified:

```bash
bundle exec rspec [list of spec files]
```

**Track the results:**
- Number of examples run
- Number of failures
- Which specs failed (if any)
- Failure messages and locations

If no specs were identified:
- Note: "No specs found for changed files"
- This might be okay (e.g., config files, markdown, migrations without specs)

### Step 4: Run Rubocop

Run Rubocop on all changed Ruby files (`.rb` files only):

```bash
bundle exec rubocop -a [changed .rb files]
```

**Track the results:**
- Number of files inspected
- Number of offenses detected
- Number of offenses auto-corrected
- Any remaining offenses that couldn't be auto-corrected

**If offenses remain after `-a`:**
- Note which files still have offenses
- Note what types of offenses remain

### Step 5: Present Summary

Create a clear, formatted summary:

```
✅ VERIFICATION SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 Changed Files: X files

🧪 SPECS
  • Examples run: X
  • Failures: X
  [If failures, list them here with file:line]

🎨 RUBOCOP
  • Files inspected: X
  • Offenses auto-corrected: X
  • Remaining offenses: X
  [If remaining offenses, list them here]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Overall status: ✅ All checks passed! / ⚠️ Issues found]
```

### Step 6: Offer to Fix Problems

**If there are spec failures:**
- Offer: "Would you like me to investigate and fix the failing specs?"

**If there are remaining Rubocop offenses:**
- Offer: "Would you like me to fix the remaining Rubocop offenses? I can try unsafe auto-corrections with `rubocop -A` or manually fix them."

**If everything passed:**
- Congratulate: "Great work! All specs pass and code follows style guidelines."

## Important Notes

- Only run specs for files that exist (don't fail on missing spec files)
- Group spec runs efficiently (one command for all specs, not one per file)
- For Rubocop, only run on Ruby files (`.rb` extension)
- Be clear about what you checked and what you didn't
- If the user wants to see more details, offer to show full output
