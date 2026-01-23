---
description: Create a private GitHub Gist from Claude's last response
allowed-tools: Bash(gh gist create:*)
---

# Create GitHub Gist from Last Response

## Your Task

Create a **private** GitHub Gist containing your most recent response from the conversation (the response immediately before the user invoked `/gist`).

### Instructions

1. **Identify the content**: Look at your last substantive response in the conversation (before `/gist` was called). This is what will be included in the gist.

2. **Create the gist**: Use the `gh` CLI to create a secret (private) gist:

```bash
gh gist create -f "claude-response.md" <<'GIST_EOF'
[Your last response content here]
GIST_EOF
```

**Notes:**
- Use `-f "claude-response.md"` to give the file a descriptive name with `.md` extension for proper markdown rendering
- Do NOT use `--public` flag (gists are secret/private by default)
- Use a heredoc with quoted delimiter (`<<'GIST_EOF'`) to preserve special characters
- Include the full response content, preserving all formatting

3. **Report the URL**: The `gh gist create` command outputs the gist URL. Report this URL to the user so they can share it with teammates.

### Output Format

After creating the gist, respond with:

```
Created private gist: <URL>
```

If the gist creation fails, report the error and suggest checking `gh auth status` to verify GitHub CLI authentication.
