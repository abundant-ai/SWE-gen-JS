#!/bin/bash

cd /app/src

# Environment variables already set in Dockerfile (CI=true)

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/dagre-wrapper"
cp "/tests/packages/mermaid/src/dagre-wrapper/edgeMarker.spec.ts" "packages/mermaid/src/dagre-wrapper/edgeMarker.spec.ts"

# Run Vitest test for the specific test file
npx vitest run packages/mermaid/src/dagre-wrapper/edgeMarker.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
