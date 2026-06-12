#!/bin/bash

AGENT_BIN="/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent"
AGENT_SERVICE="amazon-cloudwatch-agent"
CONFIG_DIR="/opt/aws/amazon-cloudwatch-agent/etc"

echo "=== CloudWatch Agent Check ==="

# Check installation
if [[ ! -x "$AGENT_BIN" ]]; then
  echo "❌ CloudWatch Agent is NOT installed."
  exit 1
fi

echo "✅ CloudWatch Agent is installed"
"$AGENT_BIN" -version 2>/dev/null

# Check service status
if systemctl is-active --quiet "$AGENT_SERVICE"; then
  echo "✅ CloudWatch Agent is running"
else
  echo "⚠️ CloudWatch Agent is installed but NOT running"
  systemctl status "$AGENT_SERVICE" --no-pager
  exit 0
fi

echo
echo "=== Active Service Status ==="
systemctl status "$AGENT_SERVICE" --no-pager

echo
echo "=== CloudWatch Agent Config Files ==="

if [[ -d "$CONFIG_DIR" ]]; then
  find "$CONFIG_DIR" -type f \( -name "*.json" -o -name "*.toml" \) | while read -r file; do
    echo
    echo "----- FILE: $file -----"
    cat "$file"
  done
else
  echo "❌ Config directory not found"
fi

echo
echo "=== Done ==="