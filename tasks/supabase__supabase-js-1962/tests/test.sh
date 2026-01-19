#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/auth-js/test"
cp "/tests/packages/core/auth-js/test/GoTrueClient.test.ts" "packages/core/auth-js/test/GoTrueClient.test.ts"
mkdir -p "packages/core/auth-js/test/lib"
cp "/tests/packages/core/auth-js/test/lib/locks.test.ts" "packages/core/auth-js/test/lib/locks.test.ts"

# Run specific lock-related tests from the auth-js package directory
# Use -t flag to run only tests matching "lock" pattern (avoids integration tests needing live server)
cd packages/core/auth-js
npx jest test/lib/locks.test.ts test/GoTrueClient.test.ts -t "lock" --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
