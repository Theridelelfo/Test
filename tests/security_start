#!/usr/bin/env sh

set -eu

echo "Running security checks..."

FILE="start.sh"

# ❌ no eval
if grep -q "eval" "$FILE"; then
  echo "❌ Security issue: eval found"
  exit 1
fi

# ❌ no backticks (command injection risk)
if grep -q "\`" "$FILE"; then
  echo "❌ Security issue: backticks found"
  exit 1
fi

# ✅ variabili quotate (best effort check)
if grep -E '\$[A-Za-z_][A-Za-z0-9_]* ' "$FILE" | grep -v '"' >/dev/null; then
  echo "⚠️ Warning: possible unquoted variables"
fi

echo "✅ Security checks passed"
