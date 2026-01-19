#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/linter.js" "tests/lib/linter/linter.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/id-blacklist.js" "tests/lib/rules/id-blacklist.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/id-denylist.js" "tests/lib/rules/id-denylist.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-inline-comments.js" "tests/lib/rules/no-inline-comments.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-promise-executor-return.js" "tests/lib/rules/no-promise-executor-return.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-setter-return.js" "tests/lib/rules/no-setter-return.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-warning-comments.js" "tests/lib/rules/no-warning-comments.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/require-await.js" "tests/lib/rules/require-await.js"
mkdir -p "tests/lib/rules/utils"
cp "/tests/lib/rules/utils/ast-utils.js" "tests/lib/rules/utils/ast-utils.js"

# Run only the specific test files that were added/modified in this PR
npx mocha tests/lib/linter/linter.js \
    tests/lib/rules/id-blacklist.js \
    tests/lib/rules/id-denylist.js \
    tests/lib/rules/no-inline-comments.js \
    tests/lib/rules/no-promise-executor-return.js \
    tests/lib/rules/no-setter-return.js \
    tests/lib/rules/no-warning-comments.js \
    tests/lib/rules/require-await.js \
    tests/lib/rules/utils/ast-utils.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
