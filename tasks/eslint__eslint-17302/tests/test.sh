#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/boolean-cast-with-assertion.js" "tests/fixtures/parsers/typescript-parsers/boolean-cast-with-assertion.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/exponentiation-with-assertion-1.js" "tests/fixtures/parsers/typescript-parsers/exponentiation-with-assertion-1.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/exponentiation-with-assertion-2.js" "tests/fixtures/parsers/typescript-parsers/exponentiation-with-assertion-2.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/exponentiation-with-assertion-3.js" "tests/fixtures/parsers/typescript-parsers/exponentiation-with-assertion-3.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/logical-assignment-with-assertion.js" "tests/fixtures/parsers/typescript-parsers/logical-assignment-with-assertion.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/logical-with-assignment-with-assertion-1.js" "tests/fixtures/parsers/typescript-parsers/logical-with-assignment-with-assertion-1.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/logical-with-assignment-with-assertion-2.js" "tests/fixtures/parsers/typescript-parsers/logical-with-assignment-with-assertion-2.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/logical-with-assignment-with-assertion-3.js" "tests/fixtures/parsers/typescript-parsers/logical-with-assignment-with-assertion-3.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/member-call-expr-with-assertion.js" "tests/fixtures/parsers/typescript-parsers/member-call-expr-with-assertion.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/unneeded-ternary-1.js" "tests/fixtures/parsers/typescript-parsers/unneeded-ternary-1.js"
mkdir -p "tests/fixtures/parsers/typescript-parsers"
cp "/tests/fixtures/parsers/typescript-parsers/unneeded-ternary-2.js" "tests/fixtures/parsers/typescript-parsers/unneeded-ternary-2.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/logical-assignment-operators.js" "tests/lib/rules/logical-assignment-operators.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-extra-boolean-cast.js" "tests/lib/rules/no-extra-boolean-cast.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-extra-parens.js" "tests/lib/rules/no-extra-parens.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-unneeded-ternary.js" "tests/lib/rules/no-unneeded-ternary.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/prefer-exponentiation-operator.js" "tests/lib/rules/prefer-exponentiation-operator.js"

# Run the specific test files using mocha
npx mocha tests/lib/rules/logical-assignment-operators.js tests/lib/rules/no-extra-boolean-cast.js tests/lib/rules/no-extra-parens.js tests/lib/rules/no-unneeded-ternary.js tests/lib/rules/prefer-exponentiation-operator.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
