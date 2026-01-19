#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/query-persist-client-core/src/__tests__"
cp "/tests/packages/query-persist-client-core/src/__tests__/createPersister.test.ts" "packages/query-persist-client-core/src/__tests__/createPersister.test.ts"
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/fine-grained-persister.test.tsx" "packages/react-query/src/__tests__/fine-grained-persister.test.tsx"

# Rebuild after copying test files (to update compiled output)
pnpm run build:all

# Run the specific test files for this PR from their package directories
cd /app/src/packages/query-persist-client-core
pnpm run test:lib src/__tests__/createPersister.test.ts --coverage.enabled=false
test_status_1=$?

cd /app/src/packages/react-query
pnpm run test:lib src/__tests__/fine-grained-persister.test.tsx --coverage.enabled=false
test_status_2=$?

# Overall test status (fail if any failed)
test_status=$((test_status_1 || test_status_2))

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
