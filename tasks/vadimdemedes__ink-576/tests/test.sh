#!/bin/bash

cd /app/src

# Set environment variables (from CI config)
export FORCE_COLOR=true
export CI=false

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/use-input.tsx" "test/fixtures/use-input.tsx"
cp "/tests/fixtures/use-input-ctrl-c.tsx" "test/fixtures/use-input-ctrl-c.tsx"
cp "/tests/fixtures/use-input-multiple.tsx" "test/fixtures/use-input-multiple.tsx"
cp "/tests/fixtures/use-stdout.tsx" "test/fixtures/use-stdout.tsx"
mkdir -p "test"
cp "/tests/hooks.tsx" "test/hooks.tsx"

# Rebuild TypeScript project to pick up any changes (e.g., if Oracle applied fix.patch)
npm run build

# Run AVA tests for the specific test file (hooks.tsx runs the fixture via node-pty)
npx ava test/hooks.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
