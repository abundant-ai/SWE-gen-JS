#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/integration/__tests__/__snapshots__"
cp "/tests/integration/__tests__/__snapshots__/file-info.js.snap" "tests/integration/__tests__/__snapshots__/file-info.js.snap"
mkdir -p "tests/integration/__tests__"
cp "/tests/integration/__tests__/file-info.js" "tests/integration/__tests__/file-info.js"
mkdir -p "tests/integration/cli/file-info/config-with-parser"
cp "/tests/integration/cli/file-info/config-with-parser/.prettierrc" "tests/integration/cli/file-info/config-with-parser/.prettierrc"
mkdir -p "tests/integration/cli/file-info/config-with-plugin"
cp "/tests/integration/cli/file-info/config-with-plugin/.prettierrc" "tests/integration/cli/file-info/config-with-plugin/.prettierrc"
mkdir -p "tests/integration/cli/file-info/empty-config"
cp "/tests/integration/cli/file-info/empty-config/.prettierrc" "tests/integration/cli/file-info/empty-config/.prettierrc"
mkdir -p "tests/integration/cli/file-info"
cp "/tests/integration/cli/file-info/plugin.js" "tests/integration/cli/file-info/plugin.js"

# Run the specific tests for this PR
# Use -u to update snapshots since bug.patch may have removed test files that had snapshots
npx jest tests/integration/__tests__/file-info.js --coverage=false --runInBand -u
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
