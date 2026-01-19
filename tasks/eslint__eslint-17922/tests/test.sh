#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/rule-tester"
cp "/tests/lib/rule-tester/rule-tester.js" "tests/lib/rule-tester/rule-tester.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/accessor-pairs.js" "tests/lib/rules/accessor-pairs.js"
cp "/tests/lib/rules/array-bracket-newline.js" "tests/lib/rules/array-bracket-newline.js"
cp "/tests/lib/rules/array-bracket-spacing.js" "tests/lib/rules/array-bracket-spacing.js"
cp "/tests/lib/rules/array-callback-return.js" "tests/lib/rules/array-callback-return.js"
cp "/tests/lib/rules/array-element-newline.js" "tests/lib/rules/array-element-newline.js"
cp "/tests/lib/rules/arrow-body-style.js" "tests/lib/rules/arrow-body-style.js"
cp "/tests/lib/rules/arrow-parens.js" "tests/lib/rules/arrow-parens.js"
cp "/tests/lib/rules/arrow-spacing.js" "tests/lib/rules/arrow-spacing.js"
cp "/tests/lib/rules/block-scoped-var.js" "tests/lib/rules/block-scoped-var.js"
cp "/tests/lib/rules/block-spacing.js" "tests/lib/rules/block-spacing.js"
cp "/tests/lib/rules/brace-style.js" "tests/lib/rules/brace-style.js"
cp "/tests/lib/rules/callback-return.js" "tests/lib/rules/callback-return.js"
cp "/tests/lib/rules/camelcase.js" "tests/lib/rules/camelcase.js"
cp "/tests/lib/rules/capitalized-comments.js" "tests/lib/rules/capitalized-comments.js"
cp "/tests/lib/rules/class-methods-use-this.js" "tests/lib/rules/class-methods-use-this.js"
cp "/tests/lib/rules/comma-dangle.js" "tests/lib/rules/comma-dangle.js"
cp "/tests/lib/rules/comma-spacing.js" "tests/lib/rules/comma-spacing.js"
cp "/tests/lib/rules/comma-style.js" "tests/lib/rules/comma-style.js"
cp "/tests/lib/rules/complexity.js" "tests/lib/rules/complexity.js"
cp "/tests/lib/rules/computed-property-spacing.js" "tests/lib/rules/computed-property-spacing.js"
cp "/tests/lib/rules/consistent-return.js" "tests/lib/rules/consistent-return.js"

# Run the specific test files using mocha
npx mocha tests/lib/rule-tester/rule-tester.js tests/lib/rules/accessor-pairs.js tests/lib/rules/array-bracket-newline.js tests/lib/rules/array-bracket-spacing.js tests/lib/rules/array-callback-return.js tests/lib/rules/array-element-newline.js tests/lib/rules/arrow-body-style.js tests/lib/rules/arrow-parens.js tests/lib/rules/arrow-spacing.js tests/lib/rules/block-scoped-var.js tests/lib/rules/block-spacing.js tests/lib/rules/brace-style.js tests/lib/rules/callback-return.js tests/lib/rules/camelcase.js tests/lib/rules/capitalized-comments.js tests/lib/rules/class-methods-use-this.js tests/lib/rules/comma-dangle.js tests/lib/rules/comma-spacing.js tests/lib/rules/comma-style.js tests/lib/rules/complexity.js tests/lib/rules/computed-property-spacing.js tests/lib/rules/consistent-return.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
