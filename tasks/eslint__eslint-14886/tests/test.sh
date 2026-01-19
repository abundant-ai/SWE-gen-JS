#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/fixtures/code-path-analysis"
cp "/tests/fixtures/code-path-analysis/class-fields-init--arrow-function.js" "tests/fixtures/code-path-analysis/class-fields-init--arrow-function.js"
mkdir -p "tests/fixtures/code-path-analysis"
cp "/tests/fixtures/code-path-analysis/class-fields-init--call-expression.js" "tests/fixtures/code-path-analysis/class-fields-init--call-expression.js"
mkdir -p "tests/fixtures/code-path-analysis"
cp "/tests/fixtures/code-path-analysis/class-fields-init--conditional.js" "tests/fixtures/code-path-analysis/class-fields-init--conditional.js"
mkdir -p "tests/fixtures/code-path-analysis"
cp "/tests/fixtures/code-path-analysis/class-fields-init--simple.js" "tests/fixtures/code-path-analysis/class-fields-init--simple.js"
mkdir -p "tests/fixtures/code-path-analysis"
cp "/tests/fixtures/code-path-analysis/function--new.js" "tests/fixtures/code-path-analysis/function--new.js"
mkdir -p "tests/fixtures/code-path-analysis"
cp "/tests/fixtures/code-path-analysis/object-literal--conditional.js" "tests/fixtures/code-path-analysis/object-literal--conditional.js"
mkdir -p "tests/lib/linter/code-path-analysis"
cp "/tests/lib/linter/code-path-analysis/code-path-analyzer.js" "tests/lib/linter/code-path-analysis/code-path-analyzer.js"
mkdir -p "tests/lib/linter/code-path-analysis"
cp "/tests/lib/linter/code-path-analysis/code-path.js" "tests/lib/linter/code-path-analysis/code-path.js"

# Run only the specific test files that were added/modified in this PR
npx mocha tests/lib/linter/code-path-analysis/code-path-analyzer.js tests/lib/linter/code-path-analysis/code-path.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
