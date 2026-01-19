#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/fixtures/shallow-glob"
cp "/tests/fixtures/shallow-glob/eslint.config.js" "tests/fixtures/shallow-glob/eslint.config.js"
mkdir -p "tests/fixtures/shallow-glob/subdir"
cp "/tests/fixtures/shallow-glob/subdir/broken.js" "tests/fixtures/shallow-glob/subdir/broken.js"
mkdir -p "tests/fixtures/shallow-glob/subdir/subsubdir"
cp "/tests/fixtures/shallow-glob/subdir/subsubdir/broken.js" "tests/fixtures/shallow-glob/subdir/subsubdir/broken.js"
mkdir -p "tests/fixtures/shallow-glob/subdir/subsubdir"
cp "/tests/fixtures/shallow-glob/subdir/subsubdir/plain.jsx" "tests/fixtures/shallow-glob/subdir/subsubdir/plain.jsx"
mkdir -p "tests/fixtures/shallow-glob/target-dir"
cp "/tests/fixtures/shallow-glob/target-dir/passing.js" "tests/fixtures/shallow-glob/target-dir/passing.js"
mkdir -p "tests/lib/eslint"
cp "/tests/lib/eslint/flat-eslint.js" "tests/lib/eslint/flat-eslint.js"

# Run only the shallow-glob related tests for this PR
npx mocha tests/lib/eslint/flat-eslint.js --grep "Globbing based on configs"
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
