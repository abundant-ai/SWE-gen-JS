#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/ohm-js/test/extras"
cp "/tests/packages/ohm-js/test/extras/test-toAST.js" "packages/ohm-js/test/extras/test-toAST.js"

# Rebuild to pick up any changes from patches (oracle agent applies fix.patch before running tests)
yarn build

# Run the specific test file from the PR
# ohm-js uses AVA
cd packages/ohm-js
npx ava test/extras/test-toAST.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
