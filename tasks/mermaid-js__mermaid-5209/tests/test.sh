#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/sequencediagram.spec.js" "cypress/integration/rendering/sequencediagram.spec.js"
mkdir -p "packages/mermaid/src/diagrams/sequence"
cp "/tests/packages/mermaid/src/diagrams/sequence/sequenceDiagram.spec.js" "packages/mermaid/src/diagrams/sequence/sequenceDiagram.spec.js"
mkdir -p "packages/mermaid/src"
cp "/tests/packages/mermaid/src/mermaid.spec.ts" "packages/mermaid/src/mermaid.spec.ts"

# Run the specific test files using Vitest
pnpm exec vitest run packages/mermaid/src/diagrams/sequence/sequenceDiagram.spec.js packages/mermaid/src/mermaid.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
