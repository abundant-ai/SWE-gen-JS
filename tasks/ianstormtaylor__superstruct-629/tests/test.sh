#!/bin/bash

cd /app/src

# Set environment variable for CI
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/api"
cp "/tests/api/mask.ts" "test/api/mask.ts"

# Run Mocha with the specific test file
npx mocha --require ./test/register.cjs --require source-map-support/register \
  test/api/mask.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
