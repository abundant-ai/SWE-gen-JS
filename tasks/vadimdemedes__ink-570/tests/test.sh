#!/bin/bash

cd /app/src

# Set environment variables (from CI config)
export FORCE_COLOR=true
export CI=false

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/borders.tsx" "test/borders.tsx"

# Rebuild TypeScript project to pick up any changes (e.g., if Oracle applied fix.patch)
npm run build

# Run AVA tests for the specific test file
npx ava test/borders.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
