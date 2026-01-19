#!/bin/bash

cd /app/src

# Set environment variables (from CI config)
export FORCE_COLOR=true
export CI=false

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/log-update.tsx" "test/log-update.tsx"
mkdir -p "test"
cp "/tests/render.tsx" "test/render.tsx"

# Run AVA tests for the specific test files (not the entire suite)
npx ava test/log-update.tsx test/render.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
