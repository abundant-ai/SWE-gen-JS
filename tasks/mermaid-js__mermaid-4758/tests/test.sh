#!/bin/bash

cd /app/src

# Environment variables already set in Dockerfile (CI=true)

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/erDiagram.spec.js" "cypress/integration/rendering/erDiagram.spec.js"
mkdir -p "packages/mermaid/src/diagrams/er/parser"
cp "/tests/packages/mermaid/src/diagrams/er/parser/erDiagram.spec.js" "packages/mermaid/src/diagrams/er/parser/erDiagram.spec.js"

# Run Vitest test for the specific test files
npx vitest run packages/mermaid/src/diagrams/er/parser/erDiagram.spec.js --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
