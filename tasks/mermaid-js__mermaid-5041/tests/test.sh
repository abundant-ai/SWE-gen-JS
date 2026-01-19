#!/bin/bash

cd /app/src

# Environment variables already set in Dockerfile (CI=true)

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/flowchart-v2.spec.js" "cypress/integration/rendering/flowchart-v2.spec.js"
mkdir -p "packages/mermaid/src/utils"
cp "/tests/packages/mermaid/src/utils/subGraphTitleMargins.spec.ts" "packages/mermaid/src/utils/subGraphTitleMargins.spec.ts"

# Run Vitest test for the specific test files
npx vitest run packages/mermaid/src/utils/subGraphTitleMargins.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
