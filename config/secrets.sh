if [ -n "$SECRETS_LOADED" ]; then
  return 0
fi

if ! bw status | grep -q "unlocked"; then
  export BW_SESSION=$(bw unlock --raw)
fi

export ANTHROPIC_API_KEY=$(bw get password "ENV_ANTHROPIC_API_KEY")
export BUNDLE_GEMS__CONTRIBSYS__COM=$(bw get password "ENV_BUNDLE_GEMS__CONTRIBSYS__COM")
export BUNDLE_REPO__FURY__IO=$(bw get password "ENV_BUNDLE_REPO__FURY__IO")
export BUNDLE_RUBYGEMS__PKG__GITHUB__COM=$(bw get password "ENV_BUNDLE_RUBYGEMS__PKG__GITHUB__COM")
export CANVAS_API_TOKEN=$(bw get password "ENV_CANVAS_API_TOKEN")
export NPM_TOKEN=$(bw get password "ENV_NPM_TOKEN")

export SECRETS_LOADED=1

echo "✓ Secrets loaded from BitWarden"
