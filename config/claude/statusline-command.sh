#!/bin/sh
input=$(cat)
worktree_name=$(echo "$input" | jq -r '.worktree.name // empty')
worktree_branch=$(echo "$input" | jq -r '.worktree.branch // empty')
cwd=$(echo "$input" | jq -r '.cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Skip directory name in worktrees (random generated names aren't useful)
if [ -z "$worktree_name" ]; then
  dir_name=$(basename "$cwd" 2>/dev/null)
else
  dir_name=""
fi

branch=""
dirty=""
if [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
  if [ -z "$branch" ] && [ -n "$worktree_branch" ]; then
    branch="$worktree_branch"
  fi
  if [ -n "$branch" ]; then
    if ! git -C "$cwd" --no-optional-locks diff --quiet 2>/dev/null || \
       ! git -C "$cwd" --no-optional-locks diff --cached --quiet 2>/dev/null; then
      dirty=" ✗"
    fi
  fi
fi

# Build output: dir git:(branch [✗]) model
output=""
if [ -n "$dir_name" ]; then
  output="$dir_name"
fi
if [ -n "$branch" ]; then
  output="$output $branch$dirty"
fi
if [ -n "$model" ]; then
  output="$output [$model]"
fi

printf '%s' "$output"
