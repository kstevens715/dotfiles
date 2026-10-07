# Claude Instructions for Ruby Projects

## Writing and Explaining

These rules apply to everything you write for me — in-session replies, PR descriptions, review comments, Slack, JIRA. Long technical findings are exactly where they slip.

### Say the concrete thing

Name what actually happens: which file, which code, what breaks. Do not use abstract verbs as a substitute for a mechanism: `engages`, `surfaces`, `lands`, `carries`, `unlocks`, `reconciles`. Do not build noun phrases that stand in for an explanation (`the first true engagement`, `a coverage gap`). Do not reuse a metaphor from the PR or ticket you are discussing (ladder/rung, seatbelt) as if it were a technical term.

Bad: "it's the second flag that first truly engages at this rung."
Good: "that flag was set in an initializer that loads too late, so it did nothing; this PR is where it starts doing something."

If a sentence would not survive being read aloud to someone at a whiteboard, rewrite it.

### One thing at a time

Explain, but explain **one** thing per reply. Do not deeply explain ten things at once — I cannot tell which one matters and the good explanation is wasted.

Pick the single most important point, explain it properly, then stop. List anything else you noticed as one-line headlines with no explanation, and let me pick which to expand. When there is a lot of supporting detail, write it to a file (a scratch file) and give me the path plus a few lines instead of pasting it all in.

### Aim at a 9th-grade reading level

Short sentences, one idea each. Ordinary words over precise-but-dense phrasing. Lead with the answer, then the why. Say "we can't tell them apart" instead of "text-fingerprint dedupe cannot merge them". Skip section headers unless the reply is genuinely long. Bold and tables only when they carry real data, never for emphasis.

### Review comments

Never append "Not a blocker" or any equivalent hedge to a PR review comment unless I ask for it on that specific comment.

### Standup notes

One or two plain sentences: the problem, then the change. No metrics, no defect lists. Keep the details as backup in case someone asks.

### Do not save writing-style rules as memories

Writing style belongs in this file, where I can read and edit it. Do not auto-create memory files for it. If I give you new guidance about how to write, propose adding it here instead.

## Commit Message Format

### Issue/Ticket Tracking

If the project uses an issue tracking system (JIRA, GitHub Issues, Linear, etc.), include the ticket identifier at the bottom of commit messages.

**Extract the ticket number from the current branch name when present.** For example:
- Branch: `feature/PROJ-296` → Use `[PROJ-296]`
- Branch: `feature/PROJ-123` → Use `[PROJ-123]`
- Branch: `bugfix/PROJ-456` → Use `[PROJ-456]`

### Commit Message Structure

```
Brief summary of the change

Detailed explanation of why the change was made, focusing on the
reasoning and context rather than what was changed (the code shows that).

Multiple paragraphs are fine if needed to explain the rationale.

[TICKET-XXX]  # Include if project uses issue tracking
```

### Example Commits

**Good Example:**
```
Rename DataManager to DataOrchestrator

The previous name "DataManager" undersold the class's actual
responsibility and made its purpose unclear. While "Manager" suggests
simple state management or CRUD operations, this class orchestrates
a complex multi-step workflow.

The class coordinates an iterative process where multiple operations
are executed, results are processed, and subsequent actions are
determined based on those results.

"DataOrchestrator" more accurately conveys this coordination
role and makes the pattern immediately clear to developers
reading the code.

[PROJ-296]
```

**Another Example:**
```
Standardize naming of DataOrchestrator to 'orchestrator'

The DataOrchestrator was being passed around with inconsistent
names: created as 'data_processor', received as 'data_processor',
and stored with different variable names. This created cognitive
overhead when reading the code flow.

Standardized all references to use 'orchestrator' consistently across
the codebase to improve readability and reduce mental load.

[PROJ-296]
```

## Keeping Feature Branches Up to Date

**Rebase feature branches onto the latest main/develop. Never merge main/develop into a feature branch.**

When asked to "fix the conflict", "update the branch", or otherwise reconcile a feature branch with its base branch, the workflow is:

1. `git fetch origin <base>` (usually `develop` or `main`)
2. `git rebase origin/<base>`
3. Resolve conflicts, `git add`/`git rm`, `git rebase --continue`
4. `git push --force-with-lease origin <branch>`

Do not run `git merge <base>` on a feature branch — merge commits on feature branches pollute history and aren't how PRs land.

## Co-Authorship

**DO NOT** add Claude as a co-author in commit messages. Do not include:
- `Co-Authored-By: Claude <noreply@anthropic.com>`
- Any reference to Claude Code generation
- Emoji indicators like 🤖

## Pull Request Format

When creating pull requests, include the ticket identifier in both the title and description:

- **Title**: Prefix with `[TICKET-XXX]` (e.g., `[PROJ-365] Fix deletion error handling`)
- **Description**: Add `[TICKET-XXX]` at the end of the PR body

Extract the ticket number from the current branch name, same as with commits.

**DO NOT** add any AI attribution to PR descriptions. Do not include:
- Lines like `Generated with [Claude Code](https://claude.com/claude-code)`
- Any mention of Claude, AI, or automated generation
- Robot emoji indicators

### Description Content

PR descriptions should explain the **purpose** of the change, not enumerate what changed in the code. The diff already shows what changed; a reviewer can read it.

**Lead with *why* the change was made.** Name the underlying problem, constraint, or initiative driving it (e.g. "endpoint X returned the same payload regardless of which application asked, leaving no room for per-instance variation").

**Say *what it gets us*.** Describe the capability, behavior, or future option the change unlocks. If it closes a gap, removes a footgun, or unblocks downstream work, name that.

**Do NOT include:**
- "Summary of code changes" sections that restate the diff in prose or bullet form.
- "Test plan" sections, unless the PR is genuinely risky and the reviewer would otherwise wonder how it was verified. The default is to omit them.
- Bullet lists enumerating files touched, methods added, or refactoring side effects.

**Good shape:** one or two short paragraphs of context and motivation, ending with `[TICKET-XXX]`.

## Ticket Tracking & Context Management

**Maintain persistent ticket context files to track requirements, decisions, and notes across chat sessions.**

### Automatic Ticket Detection

Extract the ticket ID from the current branch name when working on feature branches:
- Branch: `feature/PROJ-299` → Ticket ID: `PROJ-299`
- Branch: `bugfix/PROJ-456` → Ticket ID: `PROJ-456`

## Development Process

### Test-Driven Development (TDD)

**Prefer TDD whenever possible.** When implementing new features or fixing bugs, follow the red-green-refactor cycle:

1. **Red**: Write a failing test first that describes the expected behavior
2. **Green**: Implement the minimum code needed to make the test pass
3. **Refactor**: Clean up the code while keeping tests green

**Benefits:**
- Tests serve as executable documentation of requirements
- Ensures code is testable from the start
- Catches regressions immediately
- Forces clear thinking about expected behavior before implementation

**When to use TDD:**
- Bug fixes (write a test that reproduces the bug first)
- New features with well-defined behavior
- Refactoring existing code (ensure tests exist first)

### Presenting Test Results

**Never gloss over test failures.** When tests fail, present the results in a clear, human-readable format:

1. **State the phase**: Indicate whether we're in RED (expecting failure) or GREEN (expecting pass)
2. **Explain what the test checks**: Describe the behavior being tested in plain English
3. **Show the test inputs**: List what data is being provided
4. **Expected vs Actual**: Clearly show what was expected and what actually happened
5. **Interpretation**: Help the user understand what the failure means

**Example format:**
```
## Test Result: RED ✗

**What the test is checking:**
[Plain English description of the expected behavior]

**Test input:**
[List the relevant input data]

**Expected behavior:**
[What should happen]

**Actual behavior:**
[What is currently happening]
```

**When multiple tests fail:** Report only the most relevant failure in detail. Mention the total count of failures, but focus on one at a time. Fix that failure, then re-run to address the next. This keeps the TDD cycle focused and manageable.

This format helps the user stay engaged in the TDD process and understand what's happening at each step.

## Automatic Code Formatting

**ALWAYS run rubocop auto-correction after writing or modifying Ruby code.**

After creating or editing any Ruby files (`.rb` files), immediately run:

```bash
bundle exec rubocop -a path/to/modified_file.rb
```

If safe auto-corrections are not sufficient and rubocop still reports violations, run with `-A` for unsafe auto-corrections:

```bash
bundle exec rubocop -A path/to/modified_file.rb
```

**Workflow:**
1. Write or modify Ruby code
2. Run `bundle exec rubocop -a` on all modified files
3. Review any remaining violations that couldn't be auto-corrected
4. Manually fix remaining violations if necessary
5. Show the final, formatted code to the user

**For multiple files:**
```bash
bundle exec rubocop -a app/models/foo.rb spec/models/foo_spec.rb
```

This ensures all code adheres to the project's rubocop configuration and matches the user's editor auto-formatting behavior.

## Pre-commit Quality Check

**ALWAYS run `qlty check` on modified `.rb` files before committing.** Qlty runs in CI, so catching issues locally avoids finding out on the PR.

```bash
qlty check --no-progress path/to/modified_file.rb
```

If qlty reports issues, fix them before committing. You can run it on multiple files at once:

```bash
qlty check --no-progress app/models/foo.rb spec/models/foo_spec.rb
```

## Ruby Code Style Guidelines

### File Headers

**Copy the file header pattern used in existing project files.** Many Ruby projects include copyright notices and the frozen string literal comment at the top of files.

Examine existing files in the project to determine the header pattern. Common patterns include:

```ruby
# Copyright [Company Name]. All rights reserved. [License or confidentiality notice]

# frozen_string_literal: true
```

**Note:** Test/spec files may follow different conventions (e.g., omitting copyright but including `frozen_string_literal`). Check the project's existing test files to match their pattern.

### Spec Formatting

Within each spec (`it` block), separate the setup, execution, and assertion phases with blank lines for readability.

**Example:**
```ruby
it 'purges expired records' do
  service = create(:service, expiration_days: 1)
  old_record = create(:record, service_id: service.id, created_at: 2.days.ago)
  recent_record = create(:record, service_id: service.id, created_at: 12.hours.ago)

  service.purge_expired_records

  expect(Record.all).to match_array([recent_record])
end
```

### Method Arguments

**Prefer keyword arguments over positional arguments in method signatures.** Keyword arguments make code more readable and maintainable by explicitly naming parameters at the call site.

**Bad:**
```ruby
def process_data(user, limit, offset)
  # implementation
end

process_data(current_user, 10, 0)
```

**Good:**
```ruby
def process_data(user:, limit:, offset:)
  # implementation
end

process_data(user: current_user, limit: 10, offset: 0)
```

**Exceptions:**
- Methods following established conventions (e.g., `attr_reader`, `attr_accessor`)
- Block parameters
- Exception classes should use positional arguments

### Method Call Parentheses

**Always use parentheses on method calls.** Ruby allows omitting parentheses in many cases, but the rules are inconsistent and error-prone. Since rubocop auto-correction already runs after every change, it will remove any unnecessary parentheses automatically.

**Good:**
```ruby
user.save!()
render(json: data, status: :ok)
validate_presence_of(:name)
```

**The only exceptions** are methods that are conventionally used without parentheses as part of Ruby/Rails DSLs:
- `require` / `require_relative`
- Class-level macros: `attr_reader`, `attr_accessor`, `belongs_to`, `has_many`, `validates`, `delegate`, `scope`, `include`, `extend`, `prepend`, etc.
- Keyword-like methods: `raise`, `return`, `yield`, `puts`, `print`, `p`
- RSpec DSL: `describe`, `context`, `it`, `let`, `before`, `after`, `subject`, `expect`, `allow`, `is_expected`

When in doubt, add parentheses. Rubocop will clean up any that aren't needed.

### Class Methods

**Prefer `self.method_name` over `class << self` for defining class methods.** This style is more explicit and keeps each method definition independent.

**Bad:**
```ruby
class MyClass
  class << self
    def foo
      # implementation
    end

    def bar
      # implementation
    end
  end
end
```

**Good:**
```ruby
class MyClass
  def self.foo
    # implementation
  end

  def self.bar
    # implementation
  end
end
```

## Ruby Version Management

**chruby** is used for managing Ruby versions. Available rubies are located in `~/.rubies/`.

**Switching Ruby versions:**
```bash
chruby ruby-3.3.4    # Switch to specific version
chruby ruby-3.4.8    # Switch to another version
```

**Listing available versions:**
```bash
ls ~/.rubies/
```

## Shell (zsh)

The shell is **zsh**, and unlike bash, zsh does **not** word-split unquoted
variables. `cmd $list` passes the entire newline-joined string as ONE
argument, which breaks commands like `bundle exec rspec $spec_files`
(rspec sees a single garbage path and finds no examples).

When building a file list in a variable, expand it in one of these ways:

```bash
echo "$files" | xargs bundle exec rspec   # preferred: pipe to xargs
bundle exec rspec ${=files}               # zsh-only: force word-splitting
```

Never rely on bare `$var` expansion to split a multi-word list into
separate arguments.

## MCP Servers

The following MCP servers are available for interacting with external services. **Always prefer MCP server tools over CLI tools** for GitHub operations.

### GitHub MCP Server (`mcp__github__*`)

Use for all GitHub operations: PRs, issues, checks, releases, code search.

**Common operations:**
- `get_me` - Get current authenticated user info
- `list_pull_requests` / `search_pull_requests` - Find PRs
- `pull_request_read(method: "get")` - View PR details
- `pull_request_read(method: "get_diff")` - View PR diff
- `pull_request_read(method: "get_status")` - Check CI status
- `create_pull_request` - Create a PR
- `list_issues` / `search_issues` - Find issues
- `issue_read(method: "get")` - View issue details
- `list_commits` - List commits on a branch

**PR review workflow:**
1. `pull_request_review_write(method: "create")` - Create a pending review
2. `add_comment_to_pending_review(...)` - Add line comments
3. `pull_request_review_write(method: "submit_pending", event: "APPROVE"|"REQUEST_CHANGES"|"COMMENT")` - Submit

**Tip:** Use `search_pull_requests(query: "head:{branch} state:open")` to find the PR for the current branch.

## CLI Tools

Several code intelligence tools are available. Choosing the right one matters:

- **LSP** is *semantic*: it understands program meaning (symbol resolution, types, call graphs). Use it to navigate from a specific symbol you're looking at.
- **ast-grep** is *structural*: it matches syntactic patterns without understanding what symbols mean. Use it to find a shape of code across the codebase.
- **Grep** is *textual*: it matches raw strings and regex. Use it for non-code searches or when the pattern is simple enough that structure doesn't matter.

### LSP (built-in)

Semantic code intelligence via language servers. Understands the actual program, not just text.

**Operations:** `goToDefinition`, `findReferences`, `hover`, `documentSymbol`, `workspaceSymbol`, `goToImplementation`, `incomingCalls`, `outgoingCalls`

**When to use:**
- "Where is this method defined?" -> `goToDefinition`
- "What calls this method?" -> `incomingCalls` / `findReferences`
- "What does this class implement?" -> `goToImplementation`
- "What methods exist in this file?" -> `documentSymbol`
- "Find a class/method by name across the project" -> `workspaceSymbol`

### ast-grep (`sg`)

Structural code search and refactoring using AST patterns. Supports 20+ languages via tree-sitter.

```bash
# Find all calls to a function
sg -p 'console.log($$$ARGS)' -l js

# Find Ruby method calls with specific arguments
sg -p 'validates :$FIELD, presence: true' -l ruby

# Refactor: rewrite matching patterns
sg -p '$PROP && $PROP()' --rewrite '$PROP?.()' -l ts
```

**When to use:** Searching for a *shape* of code (function calls with certain argument patterns, specific DSL usage, structural anti-patterns) where regex would be fragile. Especially useful for large-scale refactors across many files. Unlike LSP, ast-grep doesn't need to know what a symbol *means*, just what the code *looks like*.

## Running Tests

**NEVER run the full test suite (`bundle exec rspec` with no arguments).** The suites are too large to run locally. Always run only the specific spec files relevant to your changes:

```bash
bundle exec rspec spec/services/my_service_spec.rb spec/models/my_model_spec.rb
```

## Other Guidelines

- Focus commit messages on **why** changes were made, not **what** changed
- Use present tense ("Add feature" not "Added feature")
- Keep the first line under 72 characters when possible
- Wrap body text at 72 characters
- Surround class names, variable names, function names, and other code constructs in backticks for monospace formatting on GitHub (e.g., `ClassName`, `variable_name`, `function()`)
- Use multiple commits for logically separate changes
- Squash related commits when requested
