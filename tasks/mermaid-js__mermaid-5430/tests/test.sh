#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/rendering-util"
cp "/tests/packages/mermaid/src/rendering-util/createText.spec.ts" "packages/mermaid/src/rendering-util/createText.spec.ts"

# Run the specific test file using Vitest
pnpm exec vitest run packages/mermaid/src/rendering-util/createText.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
