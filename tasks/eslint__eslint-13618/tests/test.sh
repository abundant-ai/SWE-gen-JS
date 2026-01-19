#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/constructor-super.js" "tests/lib/rules/constructor-super.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/func-name-matching.js" "tests/lib/rules/func-name-matching.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-bitwise.js" "tests/lib/rules/no-bitwise.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-extend-native.js" "tests/lib/rules/no-extend-native.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-invalid-this.js" "tests/lib/rules/no-invalid-this.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-param-reassign.js" "tests/lib/rules/no-param-reassign.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-throw-literal.js" "tests/lib/rules/no-throw-literal.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/operator-assignment.js" "tests/lib/rules/operator-assignment.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/operator-linebreak.js" "tests/lib/rules/operator-linebreak.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/prefer-destructuring.js" "tests/lib/rules/prefer-destructuring.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/prefer-promise-reject-errors.js" "tests/lib/rules/prefer-promise-reject-errors.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/space-infix-ops.js" "tests/lib/rules/space-infix-ops.js"
mkdir -p "tests/lib/rules/utils"
cp "/tests/lib/rules/utils/ast-utils.js" "tests/lib/rules/utils/ast-utils.js"

# Run specific test files using mocha with increased timeout
npx mocha --timeout 10000 \
  tests/lib/rules/constructor-super.js \
  tests/lib/rules/func-name-matching.js \
  tests/lib/rules/no-bitwise.js \
  tests/lib/rules/no-extend-native.js \
  tests/lib/rules/no-invalid-this.js \
  tests/lib/rules/no-param-reassign.js \
  tests/lib/rules/no-throw-literal.js \
  tests/lib/rules/operator-assignment.js \
  tests/lib/rules/operator-linebreak.js \
  tests/lib/rules/prefer-destructuring.js \
  tests/lib/rules/prefer-promise-reject-errors.js \
  tests/lib/rules/space-infix-ops.js \
  tests/lib/rules/utils/ast-utils.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
