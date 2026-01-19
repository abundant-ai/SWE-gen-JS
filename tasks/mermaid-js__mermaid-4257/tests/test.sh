#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/diagram-api"
cp "/tests/packages/mermaid/src/diagram-api/comments.spec.ts" "packages/mermaid/src/diagram-api/comments.spec.ts"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-comments.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-comments.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow.spec.js"

# Run specific test files using vitest
npx vitest run packages/mermaid/src/diagram-api/comments.spec.ts packages/mermaid/src/diagrams/flowchart/parser/flow-comments.spec.js packages/mermaid/src/diagrams/flowchart/parser/flow.spec.js --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
