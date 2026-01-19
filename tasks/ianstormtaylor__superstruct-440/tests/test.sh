#!/bin/bash

cd /app/src

# Set environment variable for CI
export CI=true

# Copy all HEAD test fixtures (which expect correct behavior with all failures)
# This ensures tests FAIL with buggy code (NOP) but PASS with fixed code (Oracle)
cp -r /tests/fixtures/* test/fixtures/

# Run all tests - the test runner dynamically discovers tests from test/fixtures/
npx mocha --require ./test/register.cjs --require source-map-support/register test/index.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
