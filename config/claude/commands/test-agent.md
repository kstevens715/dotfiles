---
description: Test the Skynet AI agent with verification scenarios
argument-hint: [test-scenario or custom-prompt]
allowed-tools: Bash(bundle exec rails runner:*), Read
---

# Test Skynet AI Agent

## Input Analysis

Arguments provided: `$ARGUMENTS`

## Mode Selection

**If arguments match a test scenario file name:**
- Load and run the structured test from `~/.claude/agent-tests/$ARGUMENTS.yml`

**If arguments are a custom prompt:**
- Run an ad-hoc test with the provided prompt

**If no arguments:**
- List available test scenarios and prompt user to choose

## Test Execution Strategy

### For Structured Tests (from .yml files)

1. **Load the test scenario** from the YAML file
2. **Create a conversation ID** for this test run: `test-#{timestamp}`
3. **For each prompt in the scenario:**
   - Invoke the agent using Rails runner:
     ```ruby
     DevAgentHelper.invoke("prompt here", conversation_id: "test-123")
     ```
   - Capture the response
   - Analyze against expectations
4. **Generate test report** (see below)

### For Ad-hoc Tests

1. **Create conversation ID**: `adhoc-test-#{timestamp}`
2. **Send the prompt** via DevAgentHelper.invoke
3. **Analyze the response** for:
   - Did it understand the query?
   - Did it call appropriate tools?
   - Is the response coherent and helpful?
   - Any errors or warnings?
4. **Offer follow-up**: "Would you like to ask a follow-up question to test multi-turn?"

## Invoking the Agent

Use Rails runner to call DevAgentHelper.invoke_with_telemetry (returns JSON):

```bash
cd /Users/kstevens/code/skynet
bundle exec rails runner "puts DevAgentHelper.invoke_with_telemetry('YOUR PROMPT HERE', conversation_id: 'test-conversation-id')"
```

This returns JSON with:
```json
{
  "response": "agent response text",
  "conversation_id": "test-123",
  "timestamp": "2024-01-07T10:00:00Z"
}
```

**Parse the JSON to extract:**
- The response text
- The conversation ID (for subsequent calls)
- Timestamp for performance tracking

## Analysis Framework

For each response, analyze:

### 1. **Correctness**
- Did it understand the query?
- Is the response relevant?
- Did it hallucinate or make things up?

### 2. **Tool Usage**
- Did it call appropriate tools? (look for tool mentions in response)
- Did it use tools effectively?
- Did it call tools that weren't needed?

### 3. **Quality**
- Is the response clear and well-formatted?
- Does it provide enough detail?
- Is the tone appropriate?

### 4. **Errors**
- Did any errors occur?
- How did it handle errors?
- Are there stack traces or exceptions?

### 5. **Context Retention** (for multi-turn)
- Does it remember previous questions?
- Does it reference earlier context appropriately?

## Test Report Format

After running test(s), generate a report:

```
🧪 AGENT TEST REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Test: [name]
🆔 Conversation ID: [id]
⏱️  Duration: [time]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PROMPT 1: "[prompt text]"

Agent Response:
[response preview - first 200 chars]
[... full response available on request]

Analysis:
✅ Understood query correctly
✅ Called get_coursework tool
⚠️  Response could be more specific about due dates
❌ Did not filter to science courses only

Score: 7/10

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PROMPT 2: "[prompt text]"
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

OVERALL ASSESSMENT:

✅ Strengths:
- Tool usage was appropriate
- Responses were clear and well-formatted

⚠️  Areas for Improvement:
- Filtering logic needs work
- Could retain context better

❌ Failures:
- Did not correctly identify science courses

Recommendation: [Fix the course filtering logic in get_coursework tool]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Test Results Storage

After each test run, offer to save results:

"Would you like me to save this test report to `.claude/agent-tests/results/[test-name]-[timestamp].md`?"

This creates a history of test runs to track improvements over time.

## Example Test Scenarios

Suggest creating these test files:

1. `coursework.yml` - Testing coursework retrieval
2. `student-info.yml` - Testing student information access
3. `multi-turn.yml` - Testing conversation context
4. `error-handling.yml` - Testing graceful error handling
5. `tool-selection.yml` - Testing if correct tools are chosen

## Important Notes

- Run this from the skynet directory
- Ensure Rails server is NOT running (or use a different process)
- Use unique conversation IDs for each test run
- The agent will make real API calls - be mindful of rate limits
- Compare results over time to track improvements
