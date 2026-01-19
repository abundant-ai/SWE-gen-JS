#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__"
cp "/tests/map-set.js" "__tests__/map-set.js"
mkdir -p "__tests__"
cp "/tests/patch.js" "__tests__/patch.js"

# Run Vitest on the specific test files (disable coverage to avoid threshold failures)
npx vitest run __tests__/map-set.js __tests__/patch.js --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
