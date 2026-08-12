---
name: dep-review
description: Triage and merge automated dependency-update PRs (Dependabot and Aikido) across the repos the user maintains. Finds open bot PRs in all repos tagged with a configured GitHub topic, analyzes each for merge safety via the dep-pr-analyst sub-agent, presents a numbered decision table, then — only after the user approves — approves and merges the selected PRs. Use when the user says "/dep-review", "review the dependabot PRs", "security updates", or "dependency updates".
---

# Dependency Update Review

This skill turns a pile of open Dependabot/Aikido PRs into one decision table,
and turns the user's approval into merges. The flow has a hard stop in the
middle: **nothing is approved, merged, commented on, or closed until the user
responds to the table.**

## Phase 0 — Config

Read `~/.claude/dep-review.local.json` (machine-local, not in dotfiles):

```json
{
  "org": "<github org>",
  "topic": "<repo topic that marks repos in scope>",
  "bots": ["app/dependabot", "app/aikido-autofix"]
}
```

`bots` is optional and defaults to the two logins above. If the file is
missing, ask the user for org and topic, offer to create it, and stop until
it exists.

## Phase 1 — Discover

Repos are registered by tagging them with the configured topic on GitHub
(maintainers add/remove repos by editing topics, never by editing this skill):

```bash
gh repo list <org> --topic <topic> --json nameWithOwner --limit 100
```

For each repo, list open bot PRs (plain `gh pr list` per repo — `gh search prs`
drops results when repo qualifiers are mixed with `--owner`, don't use it):

```bash
gh pr list --repo <owner/repo> --state open --limit 100 \
  --json number,title,url,author,headRefName
```

Keep PRs whose `author.login` is one of the configured bot logins. Aikido PRs
are also recognizable by branch prefix `fix/aikido-security-update-`.

## Phase 2 — Dedupe

Dependabot and Aikido frequently open duplicate PRs for the same bump (same
repo, same package, same target version). Detect these from the titles before
analyzing:

- Analyze only **one** of the pair — prefer the Dependabot PR (richer release
  notes in the body, and it auto-closes cleanly).
- The table row notes the duplicate: "merging this closes the need for #N".
- If the duplicate doesn't auto-close after the merge, closing it is part of
  the act phase for that row (the user's approval of the row covers it).

## Phase 3 — Analyze (fan out)

Spawn one `dep-pr-analyst` sub-agent per PR, all in parallel, in the
background. Each prompt gets: repo, PR number, PR URL, and (for duplicate
pairs) a note of the duplicate PR number. The analyst returns a JSON verdict —
see the `dep-pr-analyst` agent definition for the schema. Analysts are
read-only; all GitHub mutations happen in the main conversation, in Phase 5
only.

If an analyst fails or returns garbage, re-run it once; if it fails again, put
the PR in the table with recommendation `hold` and issues "analysis failed —
review manually". Never silently drop a PR: every open bot PR found in
Phase 1 must appear as at least one table row.

## Phase 4 — Present the table and STOP

One row per package (a multi-package Aikido PR gets several consecutive rows;
its recommendation is per-PR since PRs merge whole). Columns:

| # | Repo | PR | Package | Current | New | CI | Potential issues | Recommendation |

- `#` is a plain row index so the user can say "merge all except 4 and 7".
- `PR` is the PR number linked to its URL.
- `Recommendation` is `merge` / `caution` / `hold`, with dupes noted.

After the table, add a short paragraph calling out only what deserves
attention: the `caution`/`hold` rows and why, and any duplicates. Do not
re-narrate the safe rows.

Then stop and wait for the user. Their reply defines the approved set:

- "proceed" / "go ahead with your recommendations" = **only the rows
  recommended `merge`**. `caution` and `hold` rows are never included
  implicitly — each needs to be named by the user to be acted on.
- Row adjustments ("also 4", "skip 2") modify that set.

## Phase 5 — Act (only on the approved set)

For each approved PR, in sequence:

1. Re-verify it's still mergeable and green **at merge time** (the table may
   be minutes or hours old):
   ```bash
   gh pr view <n> --repo <r> --json state,mergeable,mergeStateStatus
   gh pr checks <n> --repo <r>
   ```
   If checks are red/pending, there are conflicts, or the PR is no longer
   open: **skip it and report it** — never wait-and-retry into a merge the
   user didn't watch, never override failing checks, never force anything.
2. Approve:
   ```bash
   gh pr review <n> --repo <r> --approve --body "Reviewed via dependency-update triage: <one-line rationale from the analysis>."
   ```
3. Merge using the repo's default method — query what's allowed and prefer
   merge commit, then squash, then rebase:
   ```bash
   gh repo view <r> --json mergeCommitAllowed,squashMergeAllowed,rebaseMergeAllowed
   gh pr merge <n> --repo <r> --merge --delete-branch   # or --squash / --rebase
   ```
   If the merge fails because the branch is behind a base that requires
   up-to-date branches, run `gh pr update-branch <n> --repo <r>`, then report
   that CI is re-running on it rather than blocking on it — the user can
   re-run `/dep-review` later, and the already-merged rows will have dropped
   out.
4. If the row had a noted duplicate PR and it's still open after the merge,
   close it: `gh pr close <dup> --repo <r> --comment "Duplicate of #<n>, which was merged."`

## Phase 6 — Report

End with a summary: merged (with links), skipped (with the reason each was
skipped), and anything left open for next time. Re-running the skill later is
always safe — merged PRs simply no longer appear in Phase 1.
