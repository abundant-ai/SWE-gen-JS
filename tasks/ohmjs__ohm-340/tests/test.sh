#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/cli/src"
cp "/tests/packages/cli/src/cli.test.mjs" "packages/cli/src/cli.test.mjs"

# Run the specific test file from the PR
cd packages/cli
npx ava src/cli.test.mjs
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
