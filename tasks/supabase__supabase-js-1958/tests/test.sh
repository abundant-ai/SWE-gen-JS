#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/auth-js/test"
cp "/tests/packages/core/auth-js/test/GoTrueClient.browser.test.ts" "packages/core/auth-js/test/GoTrueClient.browser.test.ts"

# Run specific test file from the auth-js package directory
cd packages/core/auth-js
npx jest test/GoTrueClient.browser.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
