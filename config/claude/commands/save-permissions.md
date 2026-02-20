---
description: Review session permissions and save selected ones to settings.json
allowed-tools: Read(/Users/kstevens/dotfiles/**), Edit(/Users/kstevens/dotfiles/**)
---

# Save Session Permissions

## Your Task

Review all tool calls made during this conversation session, identify which ones required manual approval (i.e., are not covered by existing allow rules in settings.json), and offer to add selected ones permanently.

### Step 1: Scan Conversation History

Look through the entire conversation above this command invocation. Identify every distinct tool call that was made, including:

- **Bash** commands (note the specific command and arguments)
- **Read/Edit/Write** calls (note the file paths)
- **MCP tool** calls (e.g., `mcp__github__*`, `mcp__claude_ai_Atlassian__*`)
- **WebFetch** calls (note the domains)
- **Glob/Grep** calls
- Any other tool invocations

Build a deduplicated list of tool calls, generalizing where appropriate:
- `Bash(git add foo.rb)` and `Bash(git add bar.rb)` → one entry: `Bash(git add:*)`
- `Read(/Users/kstevens/code/project/app/models/foo.rb)` and `Read(/Users/kstevens/code/project/app/models/bar.rb)` → one entry: `Read(/Users/kstevens/code/project/**)`
- Multiple calls to the same MCP tool → one entry

### Step 2: Read Current Settings

Read the current allow list:

```
~/dotfiles/config/claude/settings.json
```

Parse the `permissions.allow` array to understand what's already permanently allowed.

### Step 3: Filter Out Already-Allowed Tools

For each tool call from Step 1, check if it's already covered by an existing rule in settings.json:

**Matching rules:**
- `Bash(command prefix:*)` covers any Bash call whose command starts with that prefix
- `Read(/path/**)` covers any Read call to files under that path
- `Edit(/path/**)` covers any Edit call to files under that path
- `Write(/path/**)` covers any Write call to files under that path
- Exact MCP tool names match exactly
- `Glob` and `Grep` are auto-allowed by Claude Code and never require approval

Remove any tools that are already covered. The remaining list represents tools that required manual approval during this session.

### Step 4: Present New Permissions

If no new permissions were identified, report:

```
No new permissions to save — all tool calls this session were already covered by existing rules.
```

Otherwise, present a numbered list of suggested permission rules. For each, show:
- The suggested rule string (ready to add to settings.json)
- A brief description of what it covers

**Rule construction guidelines:**

| Tool | Pattern | Example |
|------|---------|---------|
| Bash | Generalize to subcommand level | `Bash(gh pr:*)`, `Bash(npm run:*)` |
| Read | Generalize to project directory | `Read(/Users/kstevens/code/project/**)` |
| Edit | Generalize to project directory | `Edit(/Users/kstevens/code/project/**)` |
| Write | Generalize to project directory | `Write(/Users/kstevens/code/project/**)` |
| MCP | Use exact tool name | `mcp__github__create_pull_request` |
| WebFetch | Domain-level rule | `WebFetch(domain:example.com)` |

**Grouping:** Present rules grouped by category:
1. Bash commands
2. File access (Read/Edit/Write)
3. MCP tools
4. Other

### Step 5: Ask User to Select

Use `AskUserQuestion` with `multiSelect: true` to let the user choose which permissions to add permanently. Include an "All of the above" option as the first choice for convenience.

### Step 6: Update Settings

Edit `~/dotfiles/config/claude/settings.json` to add the selected rules to the `permissions.allow` array.

**Placement rules** — insert new rules in this order within the array, matching the existing grouping:
1. `Bash(...)` rules (alphabetically)
2. `Read/Edit/Write(...)` rules (grouped by path, then alphabetically)
3. `mcp__*` rules (grouped by server, then alphabetically)
4. Other rules

Use the `Edit` tool to insert the new entries. Make sure to:
- Preserve valid JSON formatting
- Add commas correctly
- Maintain consistent indentation (6 spaces for array items, matching existing style)

### Step 7: Confirm

After editing, read back the updated settings.json and present a summary:

```
Added N permission(s) to settings.json:
  - rule1
  - rule2
  - ...
```

## Important Notes

- **Be conservative with generalization.** Don't over-broaden rules. `Bash(docker compose:*)` is better than `Bash(docker:*)` if only compose commands were used.
- **Never add dangerous commands.** Do not suggest rules for destructive operations like `rm -rf`, `git push --force`, `git reset --hard`, or `DROP TABLE`. If such commands were used, skip them and note why.
- **Respect the existing structure.** The settings.json may have other keys beyond `permissions` — preserve them exactly.
- **Glob and Grep never need rules.** These tools are auto-allowed and should not appear in suggestions.
- **ToolSearch and Task never need rules.** These are also auto-allowed.
