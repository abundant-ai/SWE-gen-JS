#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/linter/code-path-analysis"
cp "/tests/lib/linter/code-path-analysis/code-path-analyzer.js" "tests/lib/linter/code-path-analysis/code-path-analyzer.js"
mkdir -p "tests/lib/linter/code-path-analysis"
cp "/tests/lib/linter/code-path-analysis/code-path.js" "tests/lib/linter/code-path-analysis/code-path.js"
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/linter.js" "tests/lib/linter/linter.js"
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/rules.js" "tests/lib/linter/rules.js"
mkdir -p "tests/lib/rules/utils"
cp "/tests/lib/rules/utils/ast-utils.js" "tests/lib/rules/utils/ast-utils.js"
mkdir -p "tests/lib/shared"
cp "/tests/lib/shared/config-validator.js" "tests/lib/shared/config-validator.js"
mkdir -p "tests/lib/source-code"
cp "/tests/lib/source-code/source-code.js" "tests/lib/source-code/source-code.js"
mkdir -p "tests/tools"
cp "/tests/tools/eslint-fuzzer.js" "tests/tools/eslint-fuzzer.js"

# Run the specific test files using mocha
npx mocha \
  tests/lib/linter/code-path-analysis/code-path-analyzer.js \
  tests/lib/linter/code-path-analysis/code-path.js \
  tests/lib/linter/linter.js \
  tests/lib/linter/rules.js \
  tests/lib/rules/utils/ast-utils.js \
  tests/lib/shared/config-validator.js \
  tests/lib/source-code/source-code.js \
  tests/tools/eslint-fuzzer.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
