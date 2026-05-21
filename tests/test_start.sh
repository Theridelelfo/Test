#!/usr/bin/env sh

set -eu

echo "Running functional test..."

# Simula ambiente locale
unset GOOGLE_CLOUD_PROJECT
unset KILLERCODA

OUTPUT=$(sh ./start.sh 2>&1 || true)

echo "$OUTPUT" | grep "Environment detected: local"
echo "$OUTPUT" | grep "Using Dockerfile: docker/Dockerfile.base"

echo "✅ Functional test passed"
