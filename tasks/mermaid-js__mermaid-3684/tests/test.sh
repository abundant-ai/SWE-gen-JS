#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src"
cp "/tests/packages/mermaid/src/mermaidAPI.spec.ts" "packages/mermaid/src/mermaidAPI.spec.ts"
mkdir -p "packages/mermaid/src/tests"
cp "/tests/packages/mermaid/src/tests/MockedD3.ts" "packages/mermaid/src/tests/MockedD3.ts"

# Run vitest on the specific test file (use --no-threads to reduce memory usage)
npx vitest run --no-threads packages/mermaid/src/mermaidAPI.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
