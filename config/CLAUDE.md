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

## Code Style Guidelines

### File Headers

**Copy the file header pattern used in existing project files.** Many Ruby projects include copyright notices and the frozen string literal comment at the top of files.

Examine existing files in the project to determine the header pattern. Common patterns include:

```ruby
# Copyright [Company Name]. All rights reserved. [License or confidentiality notice]

# frozen_string_literal: true
```

**Note:** Test/spec files may follow different conventions (e.g., omitting copyright but including `frozen_string_literal`). Check the project's existing test files to match their pattern.

### String Quotes

**Always use single quotes for strings by default.** Use double quotes only when:
- String interpolation is required (e.g., `"Hello, #{name}"`)
- Escape sequences are needed (e.g., `"Line 1\nLine 2"`)

**Bad:**
```ruby
message = "Hello, world"
error_type = "authentication_required"
```

**Good:**
```ruby
message = 'Hello, world'
error_type = 'authentication_required'
name = 'Alice'
greeting = "Hello, #{name}"  # Double quotes needed for interpolation
```

### Symbol Arrays

**Prefer `%i[]` notation for arrays of symbols.** Use the percent-string literal syntax instead of explicit symbol array syntax for cleaner, more readable code.

**Bad:**
```ruby
services = [:stripe, :paypal, :square]
expect(error.services).to eq [:stripe, :paypal]
subject.process_payment([:stripe, :paypal])
```

**Good:**
```ruby
services = %i[stripe paypal square]
expect(error.services).to eq %i[stripe paypal]
subject.process_payment(%i[stripe paypal])
```

### Conditionals

**Prefer `if` over `unless`.** Use `if` with a negation instead of `unless` for better readability.

**Bad:**
```ruby
raise ValidationError.new(errors) unless errors.empty?
return nil unless user
process_data unless data.blank?
```

**Good:**
```ruby
raise ValidationError.new(errors) if errors.any?
return nil if user.nil?
process_data if data.present?
```

**Exception:** Simple guard clauses at the beginning of methods may use `unless` if it reads more naturally:
```ruby
return if user.nil?  # Acceptable
```

### Raising Exceptions

**Prefer the two-argument form of `raise` over calling `.new` on the exception class.**

**Bad:**
```ruby
raise StandardError.new('Something went wrong')
raise ValidationError.new(errors)
raise NotImplementedError.new('Subclasses must implement #process')
```

**Good:**
```ruby
raise StandardError, 'Something went wrong'
raise ValidationError, errors
raise NotImplementedError, 'Subclasses must implement #process'
```

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

### Variable Naming

**Always use full, descriptive variable names.** Do not abbreviate variable names.

**Bad:**
```ruby
usr = create(:user)
usr1 = create(:user)
usr2 = create(:user)
```

**Good:**
```ruby
user = create(:user)
user1 = create(:user)
user2 = create(:user)
```

### Variable Assignment

**Do not assign values to variables unless the variable is used.** If a value is only used once, use it directly instead of assigning it to a variable first.

**Bad:**
```ruby
account1 = create(:account, user:, status: :active)
account2 = create(:account, user:, status: :inactive)
# account1 and account2 are never used after creation
```

**Good:**
```ruby
create(:account, user:, status: :active)
create(:account, user:, status: :inactive)
```

### Unused Arguments

**Prefix unused arguments with an underscore** when a method must accept an argument (e.g., implementing an interface, overriding a method, or matching a required signature) but does not use it.

**Bad:**
```ruby
def error_response(request)
  error_result = { error: 'not_found' }
  # request is not used in the method body
  Response.new request:, body: error_result.to_json
end

rescue ApiError => e
  # e is not used
  handle_error
end
```

**Good:**
```ruby
def error_response(_request)
  error_result = { error: 'not_found' }
  # Underscore indicates intentionally unused
  Response.new request: _request, body: error_result.to_json
end

rescue ApiError => _e
  # Underscore indicates we don't need the exception details
  handle_error
end
```

### Method Call Parentheses

**Do not use parentheses around method calls unless required.** Parentheses are required when:
- The method takes arguments and there would be ambiguity without them
- Chaining methods
- Nested method calls

**Bad:**
```ruby
create(:user)
expect(result).to eq([])
```

**Good:**
```ruby
create :user
expect(result).to eq []
```

### Keyword Argument Shorthand

**Use keyword argument shorthand syntax when the variable name matches the keyword argument name.** Do not repeat the name unnecessarily.

**Bad:**
```ruby
create :account, user: user, status: status
PaymentService.new(customer: customer, amount: amount)
```

**Good:**
```ruby
create :account, user:, status:
PaymentService.new(customer:, amount:)
```

**Note:** When using keyword argument shorthand with method calls that would normally omit parentheses, you must include parentheses to avoid syntax ambiguity.

### Method Arguments

**Prefer keyword arguments over positional arguments in method signatures.** Keyword arguments make code more readable and maintainable by explicitly naming parameters at the call site.

**Bad:**
```ruby
def process_data(user, limit, offset)
  # implementation
end

process_data(current_user, 10, 0)

def create_record(name, description, due_date, priority)
  # implementation
end

create_record('Task 1', 'Complete work', Time.now + 1.week, 'high')
```

**Good:**
```ruby
def process_data(user:, limit:, offset:)
  # implementation
end

process_data(user: current_user, limit: 10, offset: 0)

def create_record(name:, description:, due_date:, priority:)
  # implementation
end

create_record(name: 'Task 1', description: 'Complete work', due_date: Time.now + 1.week, priority: 'high')
```

**Exceptions:**
- Methods following established conventions (e.g., `attr_reader`, `attr_accessor`)
- Block parameters

## Other Guidelines

- Focus commit messages on **why** changes were made, not **what** changed
- Use present tense ("Add feature" not "Added feature")
- Keep the first line under 72 characters when possible
- Wrap body text at 72 characters
- Surround class names, variable names, function names, and other code constructs in backticks for monospace formatting on GitHub (e.g., `ClassName`, `variable_name`, `function()`)
- Use multiple commits for logically separate changes
- Squash related commits when requested
