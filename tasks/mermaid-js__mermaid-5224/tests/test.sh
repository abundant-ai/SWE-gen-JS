#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/gantt.spec.js" "cypress/integration/rendering/gantt.spec.js"
mkdir -p "packages/mermaid/src/diagrams/gantt"
cp "/tests/packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts" "packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts"
mkdir -p "packages/mermaid/src/diagrams/gantt/parser"
cp "/tests/packages/mermaid/src/diagrams/gantt/parser/gantt.spec.js" "packages/mermaid/src/diagrams/gantt/parser/gantt.spec.js"

# Run the specific test files using Vitest
pnpm exec vitest run packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts packages/mermaid/src/diagrams/gantt/parser/gantt.spec.js --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
