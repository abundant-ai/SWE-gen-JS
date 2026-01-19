#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/ohm-js/test/snapshots"
cp "/tests/packages/ohm-js/test/snapshots/test-grammar.js.md" "packages/ohm-js/test/snapshots/test-grammar.js.md"
mkdir -p "packages/ohm-js/test/snapshots"
cp "/tests/packages/ohm-js/test/snapshots/test-grammar.js.snap" "packages/ohm-js/test/snapshots/test-grammar.js.snap"
mkdir -p "packages/ohm-js/test"
cp "/tests/packages/ohm-js/test/test-built-in-rules.js" "packages/ohm-js/test/test-built-in-rules.js"
mkdir -p "packages/ohm-js/test"
cp "/tests/packages/ohm-js/test/test-ohm-syntax.js" "packages/ohm-js/test/test-ohm-syntax.js"

# Run the specific test files from the PR
cd packages/ohm-js
npx ava test/test-built-in-rules.js test/test-ohm-syntax.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
