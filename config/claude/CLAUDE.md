# Claude Instructions for Ruby Projects

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

## Co-Authorship

**DO NOT** add Claude as a co-author in commit messages. Do not include:
- `Co-Authored-By: Claude <noreply@anthropic.com>`
- Any reference to Claude Code generation
- Emoji indicators like 🤖

## Pull Request Format

When creating pull requests, include the ticket identifier in both the title and description:

- **Title**: Prefix with `[TICKET-XXX]` (e.g., `[KSKY-365] Fix deletion error handling`)
- **Description**: Add `[TICKET-XXX]` at the end of the PR body

Extract the ticket number from the current branch name, same as with commits.

**DO NOT** add any AI attribution to PR descriptions. Do not include:
- Lines like `Generated with [Claude Code](https://claude.com/claude-code)`
- Any mention of Claude, AI, or automated generation
- Robot emoji indicators

## Ticket Tracking & Context Management

**Maintain persistent ticket context files to track requirements, decisions, and notes across chat sessions.**

### Automatic Ticket Detection

Extract the ticket ID from the current branch name when working on feature branches:
- Branch: `feature/KSKY-299` → Ticket ID: `KSKY-299`
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

## Third-Party CLI Tools

The following CLI tools are available for interacting with external services.

### GitHub CLI (`gh`)

Use for GitHub operations: PRs, issues, checks, releases.

**Login:**
```bash
gh auth login
```

**Common commands:**
- `gh pr list` - List pull requests
- `gh pr list --head <branch>` - Find PR for a specific branch
- `gh pr view <number>` - View PR details
- `gh pr create` - Create a pull request
- `gh issue list` - List issues

### Atlassian CLI (`acli`)

Use for JIRA operations: viewing tickets, searching issues, managing work items.

**Login:**
```bash
acli jira auth login --web
```

**Common commands:**
- `acli jira workitem view <KEY>` - View a JIRA ticket (e.g., `KPORTER-585`)
- `acli jira workitem view <KEY> --fields '*all'` - View all fields
- `acli jira workitem view <KEY> --web` - Open ticket in browser
- `acli jira workitem search --jql '<query>'` - Search with JQL

**Tip:** Extract the ticket key from the current branch name (e.g., `feature/KPORTER-585` → `KPORTER-585`) to look up relevant ticket details.

#### Formatting Descriptions with ADF

JIRA uses Atlassian Document Format (ADF) for rich text. Plain text or Markdown passed to `--description` will render as plain text. For proper formatting, use `--from-json` with an ADF structure.

**Generate a template:**
```bash
acli jira workitem create --generate-json  # Shows ADF structure
```

**ADF structure basics:**
```json
{
  "issues": ["KEY-123"],
  "description": {
    "type": "doc",
    "version": 1,
    "content": [
      {
        "type": "heading",
        "attrs": {"level": 2},
        "content": [{"type": "text", "text": "Section Title"}]
      },
      {
        "type": "paragraph",
        "content": [
          {"type": "text", "text": "Regular text "},
          {"type": "text", "text": "bold text", "marks": [{"type": "strong"}]},
          {"type": "text", "text": " and "},
          {"type": "text", "text": "code", "marks": [{"type": "code"}]}
        ]
      },
      {
        "type": "codeBlock",
        "attrs": {"language": "ruby"},
        "content": [{"type": "text", "text": "def foo\n  'bar'\nend"}]
      },
      {
        "type": "bulletList",
        "content": [
          {"type": "listItem", "content": [{"type": "paragraph", "content": [{"type": "text", "text": "Item 1"}]}]},
          {"type": "listItem", "content": [{"type": "paragraph", "content": [{"type": "text", "text": "Item 2"}]}]}
        ]
      },
      {
        "type": "orderedList",
        "attrs": {"order": 1},
        "content": [
          {"type": "listItem", "content": [{"type": "paragraph", "content": [{"type": "text", "text": "Step 1"}]}]}
        ]
      },
      {
        "type": "taskList",
        "attrs": {"localId": "tasks"},
        "content": [
          {"type": "taskItem", "attrs": {"state": "TODO", "localId": "t1"}, "content": [{"type": "text", "text": "Acceptance criteria item"}]}
        ]
      }
    ]
  }
}
```

**Common ADF node types:**
- `heading` - Use `attrs.level` (1-6) for h1-h6
- `paragraph` - Basic text container
- `codeBlock` - Use `attrs.language` for syntax highlighting
- `bulletList` / `orderedList` - Lists with `listItem` children
- `taskList` - Checkboxes with `taskItem` children (`state`: `TODO` or `DONE`)

**Text marks (inline formatting):**
- `{"type": "strong"}` - Bold
- `{"type": "em"}` - Italic
- `{"type": "code"}` - Inline code
- `{"type": "link", "attrs": {"href": "https://..."}}` - Hyperlink

**Workflow for creating/editing tickets:**
1. Write the ADF JSON to a temp file
2. Use `--from-json` flag: `acli jira workitem create --from-json /tmp/ticket.json`
3. For creates, use `"projectKey": "PROJ"`, `"type": "Bug"`, and `"summary": "..."`
4. For edits, use `"issues": ["KEY-123"]` instead of projectKey

## Other Guidelines

- Focus commit messages on **why** changes were made, not **what** changed
- Use present tense ("Add feature" not "Added feature")
- Keep the first line under 72 characters when possible
- Wrap body text at 72 characters
- Surround class names, variable names, function names, and other code constructs in backticks for monospace formatting on GitHub (e.g., `ClassName`, `variable_name`, `function()`)
- Use multiple commits for logically separate changes
- Squash related commits when requested
