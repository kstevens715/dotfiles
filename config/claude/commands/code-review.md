---
description: Review PRs where your review has been requested
allowed-tools: Bash(git:*), Bash(cd:*), Read, Edit, Glob, Grep, mcp__github__*
---

# Code Review Mode

You are now in code review mode. Follow these instructions for the entire session until the user exits or completes all reviews.

Use the GitHub MCP server tools for all GitHub interactions instead of the `gh` CLI.

## Step 1: List Pending Reviews

First, get the current user's login with `get_me`, then use `search_pull_requests` to find open PRs where your review has been requested:

```
search_pull_requests(query: "review-requested:{login} state:open")
```

For each PR, display:
- Clickable link to the PR
- Repository name
- Title
- Author
- Draft status (if draft, note this prominently)
- Last updated

If you can efficiently get status check information (e.g., via `pull_request_read` with method `get_status`), show whether checks are passing/failing/pending. Otherwise, defer this to when the review begins.

**Format the list clearly**, then ask: "Would you like to start reviewing the first PR?"

## Step 2: Begin a Review

When the user agrees to review a PR:

### 2a. Fetch PR Details

Get comprehensive PR information:

```
pull_request_read(method: "get", owner: "{owner}", repo: "{repo}", pullNumber: {number})
```

### 2b. Check for Blockers First

**Immediately tell the user if:**
- The PR is in **draft** status
- Status checks are **failing** or still **pending** (use `pull_request_read` with method `get_status`)

This information should be presented first, before diving into code details.

### 2c. Review Commits

List all commits on the PR:

```
list_commits(owner: "{owner}", repo: "{repo}", sha: "{head_branch}")
```

Present the commit list. If any commit messages are poor quality (vague like "fix", "update", "WIP", missing context, or don't follow conventional patterns), point this out.

### 2d. Review the Changes

Fetch and analyze the diff:

```
pull_request_read(method: "get_diff", owner: "{owner}", repo: "{repo}", pullNumber: {number})
```

Provide your assessment:
- Summary of what the PR does
- Any concerns or issues you notice
- Code quality observations
- Whether you recommend approval, changes requested, or need more context

### 2e. Offer to Checkout

Ask: "Would you like me to checkout this branch locally?"

If yes:
1. Determine the correct local directory based on the repository name (under `~/code/`)
2. Stash any uncommitted changes
3. Fetch latest from remote
4. Checkout the PR branch

```bash
cd ~/code/{repo-name} && git stash && git fetch origin && git checkout {branch-name}
```

## Step 3: During Review Mode

While reviewing a PR:

### Adding Comments

When the user asks you to add comments to the PR, use the pending review workflow:

1. Create a pending review:
```
pull_request_review_write(method: "create", owner: "{owner}", repo: "{repo}", pullNumber: {number})
```

2. Add comments to the pending review:
```
add_comment_to_pending_review(owner: "{owner}", repo: "{repo}", pullNumber: {number}, path: "{file_path}", line: {line_number}, body: "{comment}", subjectType: "LINE", side: "RIGHT")
```

3. Submit when ready (see "Submitting the Review" below).

### Approving PRs

When approving, do **NOT** include an overall comment unless the user explicitly provides one:

```
pull_request_review_write(method: "create", owner: "{owner}", repo: "{repo}", pullNumber: {number}, event: "APPROVE")
```

### Requesting Changes

```
pull_request_review_write(method: "create", owner: "{owner}", repo: "{repo}", pullNumber: {number}, event: "REQUEST_CHANGES", body: "{comment}")
```

### Submitting the Review

If a pending review exists, submit it:

```
pull_request_review_write(method: "submit_pending", owner: "{owner}", repo: "{repo}", pullNumber: {number}, event: "COMMENT", body: "{optional summary}")
```

After submitting, **automatically move to the next PR** in the list. Present the next PR's summary and ask if they want to review it.

## Important Rules

1. **Always include clickable PR links** when referring to PRs
2. **Surface blockers immediately** - draft status and failing checks should be the first thing mentioned
3. **Pending review comments** - never post comments directly, always as part of a pending review
4. **No approval comments** unless explicitly told to include one
5. **Auto-advance** - after submitting a review, move to the next PR
6. **Commit message quality** - always review commit messages and call out issues
7. **Local checkout** - when checking out, always stash first to preserve work
