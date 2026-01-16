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

## Ticket Tracking & Context Management

**Maintain persistent ticket context files to track requirements, decisions, and notes across chat sessions.**

### Automatic Ticket Detection

Extract the ticket ID from the current branch name when working on feature branches:
- Branch: `feature/KSKY-299` → Ticket ID: `KSKY-299`
- Branch: `bugfix/PROJ-456` → Ticket ID: `PROJ-456`

### Ticket File Management

**Location:** `.claude/tickets/{TICKET_ID}.md` (within each project)

**When to create/update:**
1. **New conversation on feature branch**: Check if `.claude/tickets/{TICKET_ID}.md` exists
   - If it exists: Read it first to load context
   - If it doesn't exist: Create it from the template when the user starts providing relevant information

2. **During work**: Update the ticket file as the user shares:
   - Requirements and acceptance criteria
   - Meeting notes and decisions
   - Edge cases to handle
   - Testing considerations
   - Open questions or blockers
   - Technical decisions made

3. **Update proactively**: When the user mentions important context, requirements, or decisions, add them to the appropriate section without being asked

**Template:** Use the template at `~/.claude/templates/ticket-template.md` when creating new ticket files. Replace `{TICKET_ID}` with the actual ticket ID.

### Ticket File Sections

The template includes these sections:
- **Overview**: Brief description of the ticket's purpose
- **Requirements**: Key requirements and acceptance criteria
- **Meeting Notes**: Notes captured from meetings/discussions
- **Technical Decisions**: Architecture, implementation approach, library choices
- **Edge Cases & Considerations**: Special cases, gotchas, things to watch out for
- **Testing Checklist**: What needs to be tested
- **Open Questions**: Things that need clarification
- **References**: Links to docs, related tickets, JIRA, etc.

### Workflow

This complements the TodoWrite tool:
- **TodoWrite**: Immediate task tracking for the current session (what to do now)
- **Ticket files**: Persistent context and requirements (why we're doing it, what to remember)

The ticket file should be a living document that captures important context so it's never lost between chat sessions.

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

## Other Guidelines

- Focus commit messages on **why** changes were made, not **what** changed
- Use present tense ("Add feature" not "Added feature")
- Keep the first line under 72 characters when possible
- Wrap body text at 72 characters
- Surround class names, variable names, function names, and other code constructs in backticks for monospace formatting on GitHub (e.g., `ClassName`, `variable_name`, `function()`)
- Use multiple commits for logically separate changes
- Squash related commits when requested
