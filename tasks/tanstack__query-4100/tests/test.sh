#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query-devtools/src/__tests__"
cp "/tests/packages/react-query-devtools/src/__tests__/devtools.test.tsx" "packages/react-query-devtools/src/__tests__/devtools.test.tsx"

# Run jest from root for react-query-devtools tests
./node_modules/.bin/jest --config ./jest.config.ts \
  packages/react-query-devtools/src/__tests__/devtools.test.tsx \
  --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
