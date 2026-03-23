#!/bin/bash
set -euo pipefail

# Only run in remote (web) sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Try installing via the official plugin marketplace first
if ! claude plugin list 2>/dev/null | grep -q "figma"; then
  echo "Installing Figma plugin..."
  if claude plugin install figma@claude-plugins-official 2>/dev/null; then
    echo "Figma plugin installed successfully."
  else
    echo "Plugin marketplace unavailable. Configuring Figma via MCP server..."
    claude mcp add --transport http figma https://mcp.figma.com/mcp 2>/dev/null || \
      echo "Figma MCP already configured or skipped."
  fi
else
  echo "Figma plugin already installed."
fi
