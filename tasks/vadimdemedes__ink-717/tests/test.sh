#!/bin/bash

cd /app/src

# Set environment variables (from CI config)
export FORCE_COLOR=true
export CI=false

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/erase-with-state-change.tsx" "test/fixtures/erase-with-state-change.tsx"
mkdir -p "test"
cp "/tests/render.tsx" "test/render.tsx"

# Rebuild TypeScript project to pick up any changes (e.g., if Oracle applied fix.patch)
npm run build

# Run AVA tests for the specific test file
# Note: erase-with-state-change.tsx is a fixture used by render.tsx tests, not a test itself
npx ava test/render.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
