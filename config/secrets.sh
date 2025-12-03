if [ -n "$SECRETS_LOADED" ]; then
  return 0
fi

# Define secrets to fetch from Bitwarden
# Format: "ENV_VAR_NAME:BW_ITEM_NAME"
SECRETS=(
  "ANTHROPIC_API_KEY:ENV_ANTHROPIC_API_KEY"
  "BUNDLE_GEMS__CONTRIBSYS__COM:ENV_BUNDLE_GEMS__CONTRIBSYS__COM"
  "BUNDLE_REPO__FURY__IO:ENV_BUNDLE_REPO__FURY__IO"
  "BUNDLE_RUBYGEMS__PKG__GITHUB__COM:ENV_BUNDLE_RUBYGEMS__PKG__GITHUB__COM"
  "CANVAS_API_TOKEN:ENV_CANVAS_API_TOKEN"
  "NPM_TOKEN:ENV_NPM_TOKEN"
)

# Store session and secrets in temporary files that persist across shells
BW_SESSION_FILE="/tmp/bw_session_${USER}"
BW_SECRETS_CACHE="/tmp/bw_secrets_${USER}"

# Load secrets from cache if available (fast path)
if [ -f "$BW_SECRETS_CACHE" ]; then
  source "$BW_SECRETS_CACHE"
else
  # Cache doesn't exist, need to fetch from Bitwarden
  # Load existing session if available
  if [ -f "$BW_SESSION_FILE" ]; then
    export BW_SESSION=$(cat "$BW_SESSION_FILE")
  fi

  # Check if session is valid, unlock if needed
  if ! bw unlock --check &>/dev/null; then
    export BW_SESSION=$(bw unlock --raw)
    echo "$BW_SESSION" > "$BW_SESSION_FILE"
    chmod 600 "$BW_SESSION_FILE"
  fi

  # Fetch secrets from Bitwarden and build cache file
  > "$BW_SECRETS_CACHE"
  for secret in "${SECRETS[@]}"; do
    VAR_NAME="${secret%%:*}"
    BW_ITEM="${secret##*:}"
    VALUE=$(bw get password "$BW_ITEM")
    export "$VAR_NAME=$VALUE"
    echo "export $VAR_NAME='$VALUE'" >> "$BW_SECRETS_CACHE"
  done
  chmod 600 "$BW_SECRETS_CACHE"
fi

export SECRETS_LOADED=1

echo "✓ Secrets loaded from BitWarden"
