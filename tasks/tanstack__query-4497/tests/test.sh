#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/eslint-plugin-query/src/rules/prefer-query-object-syntax"
cp "/tests/packages/eslint-plugin-query/src/rules/prefer-query-object-syntax/prefer-query-object-syntax.test.ts" "packages/eslint-plugin-query/src/rules/prefer-query-object-syntax/prefer-query-object-syntax.test.ts"
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useQuery.test.tsx" "packages/react-query/src/__tests__/useQuery.test.tsx"

# Run the specific test file for eslint-plugin-query
cd packages/eslint-plugin-query
../../node_modules/.bin/jest --config ./jest.config.ts src/rules/prefer-query-object-syntax/prefer-query-object-syntax.test.ts --coverage=false
eslint_test_status=$?

# Run the specific test file for react-query
cd ../react-query
../../node_modules/.bin/jest --config ./jest.config.ts src/__tests__/useQuery.test.tsx --coverage=false
react_test_status=$?

# Both tests must pass
if [ $eslint_test_status -eq 0 ] && [ $react_test_status -eq 0 ]; then
  test_status=0
else
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
