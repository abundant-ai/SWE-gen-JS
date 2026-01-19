#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/fixtures/cli/ignore-pattern-relative"
cp "/tests/fixtures/cli/ignore-pattern-relative/.eslintrc.js" "tests/fixtures/cli/ignore-pattern-relative/.eslintrc.js"
mkdir -p "tests/fixtures/cli/ignore-pattern-relative"
cp "/tests/fixtures/cli/ignore-pattern-relative/eslint.config.js" "tests/fixtures/cli/ignore-pattern-relative/eslint.config.js"
mkdir -p "tests/fixtures/cli/ignore-pattern-relative/subdir/subsubdir"
cp "/tests/fixtures/cli/ignore-pattern-relative/subdir/subsubdir/a.js" "tests/fixtures/cli/ignore-pattern-relative/subdir/subsubdir/a.js"
mkdir -p "tests/lib"
cp "/tests/lib/cli.js" "tests/lib/cli.js"

# Run the specific test files for this PR
npx mocha tests/lib/cli.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
