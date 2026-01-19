#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src"
cp "/tests/packages/mermaid/src/styles.spec.ts" "packages/mermaid/src/styles.spec.ts"

# Run specific test file using vitest
npx vitest run packages/mermaid/src/styles.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
