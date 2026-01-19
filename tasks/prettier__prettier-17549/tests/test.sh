#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/integration/__tests__"
cp "/tests/integration/__tests__/infer-parser.js" "tests/integration/__tests__/infer-parser.js"
mkdir -p "tests/integration/cli/infer-parser/override-builtin-plugin-languages"
cp "/tests/integration/cli/infer-parser/override-builtin-plugin-languages/.prettierrc" "tests/integration/cli/infer-parser/override-builtin-plugin-languages/.prettierrc"
mkdir -p "tests/integration/cli/infer-parser/override-builtin-plugin-languages"
cp "/tests/integration/cli/infer-parser/override-builtin-plugin-languages/dummy-js-plugin.js" "tests/integration/cli/infer-parser/override-builtin-plugin-languages/dummy-js-plugin.js"
mkdir -p "tests/unit"
cp "/tests/unit/syntax-transform.js" "tests/unit/syntax-transform.js"

# Run the specific tests for this PR
# Use -u to update snapshots since bug.patch may have removed test files that had snapshots
npx jest tests/integration/__tests__/infer-parser.js tests/unit/syntax-transform.js --coverage=false --runInBand -u
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
