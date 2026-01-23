---
description: Review PRs where your review has been requested
allowed-tools: Bash(gh:*), Bash(git:*), Bash(cd:*), Read, Edit, Glob, Grep
---

# Code Review Mode

You are now in code review mode. Follow these instructions for the entire session until the user exits or completes all reviews.

## Step 1: List Pending Reviews

Fetch all PRs where a review has been requested from the user:

```bash
gh search prs --review-requested=@me --state=open --json repository,number,title,url,isDraft,author,updatedAt
```

For each PR, display:
- Clickable link to the PR
- Repository name
- Title
- Author
- Draft status (if draft, note this prominently)
- Last updated

If you can efficiently get status check information (e.g., if it's included in the response or requires minimal extra calls), show whether checks are passing/failing/pending. Otherwise, defer this to when the review begins.

**Format the list clearly**, then ask: "Would you like to start reviewing the first PR?"

## Step 2: Begin a Review

When the user agrees to review a PR:

### 2a. Fetch PR Details

Get comprehensive PR information:

```bash
gh pr view {number} --repo {owner/repo} --json title,body,author,headRefName,baseRefName,isDraft,files,additions,deletions,commits,reviews,statusCheckRollup
```

### 2b. Check for Blockers First

**Immediately tell the user if:**
- The PR is in **draft** status
- Status checks are **failing** or still **pending**

This information should be presented first, before diving into code details.

### 2c. Review Commits

List all commits with their summary lines:

```bash
gh pr view {number} --repo {owner/repo} --json commits --jq '.commits[] | "\(.oid[0:7]) \(.messageHeadline)"'
```

Present the commit list. If any commit messages are poor quality (vague like "fix", "update", "WIP", missing context, or don't follow conventional patterns), point this out.

### 2d. Review the Changes

Fetch and analyze the diff:

```bash
gh pr diff {number} --repo {owner/repo}
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

When the user asks you to add comments to the PR, add them as **pending review comments** (not individual comments):

```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments \
  --method POST \
  -f body='{comment}' \
  -f commit_id='{commit_sha}' \
  -f path='{file_path}' \
  -f line={line_number}
```

Or for a review with multiple comments, create a pending review:

```bash
gh api repos/{owner}/{repo}/pulls/{number}/reviews \
  --method POST \
  -f event='PENDING' \
  -f body='' \
  --jq '.id'
```

Then add comments to that review.

### Approving PRs

When approving, do **NOT** include an overall comment unless the user explicitly provides one:

```bash
gh pr review {number} --repo {owner/repo} --approve
```

### Requesting Changes

```bash
gh pr review {number} --repo {owner/repo} --request-changes --body "{comment}"
```

### Submitting the Review

When the user says to submit the review, submit it and then **automatically move to the next PR** in the list. Present the next PR's summary and ask if they want to review it.

## Step 4: Marking Notifications as Done

After completing a review (approve/request changes/comment), offer to mark the GitHub notification as done:

```bash
# Find the notification thread ID
gh api '/notifications?all=true' --jq '.[] | select(.subject.url | contains("pulls/{number}")) | .id'

# Mark as done
gh api --method DELETE /notifications/threads/{thread_id}
```

## Important Rules

1. **Always include clickable PR links** when referring to PRs
2. **Surface blockers immediately** - draft status and failing checks should be the first thing mentioned
3. **Pending review comments** - never post comments directly, always as part of a pending review
4. **No approval comments** unless explicitly told to include one
5. **Auto-advance** - after submitting a review, move to the next PR
6. **Commit message quality** - always review commit messages and call out issues
7. **Local checkout** - when checking out, always stash first to preserve work
