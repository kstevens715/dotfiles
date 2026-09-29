#!/usr/bin/env bash

if [ -n "$SECRETS_LOADED" ]; then
  return 0 2>/dev/null || exit 0
fi

# Name of the Bitwarden folder containing your secrets
BW_FOLDER_NAME="ENV"

# Store session and secrets in temporary files that persist across shells
BW_SESSION_FILE="/tmp/bw_session_${USER}"
BW_SECRETS_CACHE="/tmp/bw_secrets_${USER}"

# Load secrets from cache if available (fast path)
if [ -f "$BW_SECRETS_CACHE" ]; then
  source "$BW_SECRETS_CACHE"
else
  # Cache doesn't exist, need to fetch from Bitwarden
  # Unlock can't prompt when the CLI has no logged-in account
  if [ "$(bw status 2>/dev/null | jq -r '.status' 2>/dev/null)" = "unauthenticated" ]; then
    echo "Bitwarden CLI is logged out. Run 'bw login', then 'reload_secrets'." >&2
    return 1 2>/dev/null || exit 1
  fi

  # Load existing session if available
  if [ -f "$BW_SESSION_FILE" ]; then
    export BW_SESSION=$(cat "$BW_SESSION_FILE")
  fi

  # Check if session is valid, unlock if needed
  if ! bw unlock --check &>/dev/null; then
    # Only prompt for the master password in an interactive terminal, so
    # editor tasks and other non-interactive shells don't hang
    if [[ $- != *i* ]] || [ ! -t 0 ]; then
      return 1 2>/dev/null || exit 1
    fi

    BW_SESSION=$(bw unlock --raw)
    if [ -z "$BW_SESSION" ]; then
      unset BW_SESSION
      echo "Bitwarden unlock failed. Run 'reload_secrets' to try again." >&2
      return 1 2>/dev/null || exit 1
    fi

    export BW_SESSION
    echo "$BW_SESSION" > "$BW_SESSION_FILE"
    chmod 600 "$BW_SESSION_FILE"
  fi

  # Sync to get latest items from server
  bw sync &>/dev/null

  # Get folder ID
  FOLDER_ID=$(bw list folders | jq -r ".[] | select(.name==\"$BW_FOLDER_NAME\") | .id")

  if [ -z "$FOLDER_ID" ]; then
    echo "Error: Folder '$BW_FOLDER_NAME' not found in Bitwarden"
    return 1 2>/dev/null || exit 1
  fi

  # Fetch all items from the folder and build cache file
  rm -f "$BW_SECRETS_CACHE"
  touch "$BW_SECRETS_CACHE"

  # Fetch all items and filter by folder
  ITEMS_JSON=$(bw list items | jq --arg folder_id "$FOLDER_ID" '[.[] | select(.folderId == $folder_id)]')

  # Parse items and write to cache
  echo "$ITEMS_JSON" | jq -r '.[] | select(.login.password != null) | "\(.name)|\(.login.password)"' | while IFS='|' read -r VAR_NAME VALUE; do
    if [ -n "$VAR_NAME" ] && [ -n "$VALUE" ]; then
      echo "export $VAR_NAME='$VALUE'" >> "$BW_SECRETS_CACHE"
    fi
  done
  chmod 600 "$BW_SECRETS_CACHE"

  # Source the cache file we just created to export the variables
  source "$BW_SECRETS_CACHE"
fi

export SECRETS_LOADED=1

echo "✓ Secrets loaded from Bitwarden"
