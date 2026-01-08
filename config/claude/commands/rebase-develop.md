---
description: Rebase current branch onto latest develop
allowed-tools: Bash(git:*)
---

# Rebase Current Branch onto Develop

## Current Git State

- Current branch: !`git branch --show-current`
- Working tree status: !`git status --porcelain`

## Your Task

Perform a complete rebase workflow to update the current branch with the latest changes from develop. Follow these steps carefully:

### Step 1: Stash Changes (if needed)

**If uncommitted changes exist:**
- Stash them with: `git stash push -m "Temporary stash for rebase-develop"`
- Remember that we stashed changes (important for Step 6)

**If no uncommitted changes:**
- Skip stashing and proceed to Step 2

### Step 2: Update Develop Branch

1. Checkout develop: `git checkout develop`
2. Fetch latest changes: `git fetch origin`
3. Rebase develop onto origin/develop: `git rebase origin/develop`

**If conflicts occur during develop rebase:**
- This is unusual and indicates develop has diverged
- Abort with `git rebase --abort`
- Inform the user and ask for guidance before proceeding

### Step 3: Return to Original Branch

- Checkout the original branch (from "Current branch" above)

### Step 4: Rebase onto Develop

- Issue: `git rebase develop`

**If conflicts occur:**
- Run `git status` to see conflicting files
- For EACH conflicting file:
  - Read the file to see the conflict markers
  - Analyze both sides of the conflict (HEAD vs develop)
  - **Present a recommendation** for how to resolve it, explaining:
    - What HEAD (current branch) is trying to do
    - What develop is trying to do
    - Your suggested resolution and why
  - **Ask the user**: "Does this resolution look correct, or would you like me to do something different?"
  - **Wait for user response** before making changes
  - Make the changes based on user confirmation/modification
  - Stage the resolved file with `git add`
- After all conflicts are resolved: `git rebase --continue`
- Repeat conflict resolution if more conflicts appear in subsequent commits

**If rebase succeeds without conflicts:**
- Proceed to Step 5

### Step 5: Verify Success

- Run `git log --oneline -5` to show recent commits
- Run `git status` to verify clean working tree
- Confirm rebase completed successfully

### Step 6: Restore Stashed Changes (if applicable)

**If we stashed changes in Step 1:**
1. Apply the stash: `git stash pop`

**If conflicts occur when applying stash:**
- Run `git status` to see conflicting files
- For EACH conflicting file:
  - Read the file to see the conflict markers
  - Analyze both sides (stashed changes vs current state)
  - **Present a recommendation** for resolution, explaining what the stashed changes were trying to accomplish
  - **Ask the user**: "Does this resolution look correct, or would you like me to do something different?"
  - **Wait for user response** before making changes
  - Make the changes based on user confirmation/modification
  - Stage the resolved file with `git add`
- After resolving all conflicts, the stash pop is complete (no need to continue)

**If stash applies cleanly:**
- Verify with `git status`
- Confirm all changes have been restored

**If we did NOT stash changes in Step 1:**
- Skip this step

## Important Notes

- **Never** force push without explicit user permission
- Always explain your reasoning when resolving conflicts
- If you're uncertain about a conflict resolution, ask the user for guidance
- The user knows the codebase better than you do - defer to their judgment
- Be interactive: present recommendations, wait for confirmation, then act
