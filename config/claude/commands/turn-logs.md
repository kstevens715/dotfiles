---
description: Search CloudWatch logs for a Skynet turn by turn_id
allowed-tools: Bash(aws logs:*)
---

# Search CloudWatch Logs by Turn ID

## Arguments

- `$ARGUMENTS` — The turn_id (UUID) to search for

## Your Task

Search CloudWatch Logs Insights for Skynet Sidekiq logs matching a specific `turn_id`.

### Step 1: Validate Input

The user must provide a turn_id as `$ARGUMENTS`. If it's empty or doesn't look like a UUID, ask the user to provide one.

### Step 2: Run the CloudWatch Insights Query

Query both the production and staging Sidekiq log groups simultaneously using CloudWatch Logs Insights.

**Log groups:**
- `/eks/saas-production/applications/skynet-prod.sidekiq`
- `/eks/saas-staging/applications/skynet-staging.sidekiq`

**Default time range:** Last 1 hour. Calculate `start-time` and `end-time` as epoch seconds:

```bash
END_TIME=$(date +%s)
START_TIME=$((END_TIME - 3600))
```

**Start the query:**

```bash
QUERY_ID=$(aws logs start-query \
  --log-group-names \
    '/eks/saas-production/applications/skynet-prod.sidekiq' \
    '/eks/saas-staging/applications/skynet-staging.sidekiq' \
  --start-time "$START_TIME" \
  --end-time "$END_TIME" \
  --query-string "fields @timestamp, @message | filter @message like 'turn_id=$ARGUMENTS' | sort @timestamp desc | limit 10000" \
  --output text --query 'queryId')
```

### Step 3: Poll for Results

The query runs asynchronously. **Write results to a temp file** — do NOT try to capture the JSON in a shell variable, as the output contains special characters that break inline jq parsing.

```bash
STATUS="Running"
while [ "$STATUS" = "Running" ] || [ "$STATUS" = "Scheduled" ]; do
  sleep 1
  aws logs get-query-results --query-id "$QUERY_ID" > /tmp/cw_results.json
  STATUS=$(jq -r '.status' /tmp/cw_results.json)
done
```

Then check the count and extract results:

```bash
jq '.results | length' /tmp/cw_results.json
jq -r '.results[] | [(.[] | select(.field == "@timestamp") | .value), (.[] | select(.field == "@message") | .value)] | "\(.[0])\t\(.[1])"' /tmp/cw_results.json | sort
```

### Step 4: Present Results

A turn represents a single invocation of a Skynet agent via `InvokeAgentJob` in Sidekiq. The logs trace the full lifecycle. Present results as a summary followed by a timeline table.

**Summary section** — extract and show:
- **Turn ID**
- **Environment**: staging or production (from `namespace_name` in the kubernetes metadata)
- **Pod**: the `pod_name` from kubernetes metadata
- **Job**: class name and Sidekiq jid
- **User query**: the `query` field from the `ConversationLogEntry` INSERT
- **Agent response**: the `response` field from the `ConversationLogEntry` INSERT
- **Total duration**: from the metadata event's `latency_ms` or `time-elapsed`
- **Token usage**: `input_tokens` and `output_tokens` from the metadata event
- **Total log entries**: count of results

**Timeline table** — show key lifecycle events in chronological order:

| Time | Event |
|---|---|
| timestamp | Job starts — loads KnowledgeAgentInstance |
| timestamp | Loads CannedResponses, ApplicationInstance, Persona |
| timestamp | `message_start` — LLM response begins (note elapsed time) |
| timestamp | Content deltas streamed (summarize the text fragments) |
| timestamp | Lambda broadcasts to client via kgo-sockets |
| timestamp | `message_stop` — stop reason |
| timestamp | ConversationLogEntry saved |
| timestamp | Metadata — token counts, latency |

**Collapse repetitive entries** — there will be many cached DB loads and streaming deltas. Don't show every one individually; group them (e.g., "Multiple cached CannedResponse loads" or "Content streamed in N deltas").

**Highlight any errors, exceptions, or warnings** if present in the logs.

### Step 5: If No Results Found

If zero results are returned with the 1-hour window:

1. Tell the user no results were found in the last hour
2. Ask if they'd like to search a wider time range (e.g., last 6 hours, last 24 hours, or a custom range)
3. Re-run the query with the adjusted time range if requested

### Notes

- The query may take a few seconds to complete — wait for status `Complete` before reading results
- Results are sorted by timestamp descending from the query, but present them chronologically (oldest first) for readability
- If AWS credentials are expired or missing, inform the user to refresh their SSO session
