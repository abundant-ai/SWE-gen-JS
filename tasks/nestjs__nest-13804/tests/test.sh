#!/bin/bash

cd /app/src

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/lazy-modules/e2e"
cp "/tests/integration/lazy-modules/e2e/lazy-import-transient-providers.spec.ts" "integration/lazy-modules/e2e/lazy-import-transient-providers.spec.ts"

# Run the specific test file using mocha
npx mocha integration/lazy-modules/e2e/lazy-import-transient-providers.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
