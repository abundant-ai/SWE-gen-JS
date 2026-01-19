#!/bin/bash

cd /app/src

# Environment variables already set in Dockerfile (CI=true)

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/sequencediagram.spec.js" "cypress/integration/rendering/sequencediagram.spec.js"
mkdir -p "packages/mermaid/src/diagrams/class"
cp "/tests/packages/mermaid/src/diagrams/class/classDiagramGrammar.spec.ts" "packages/mermaid/src/diagrams/class/classDiagramGrammar.spec.ts"
mkdir -p "packages/mermaid/src/diagrams/sequence"
cp "/tests/packages/mermaid/src/diagrams/sequence/sequenceDiagram.spec.js" "packages/mermaid/src/diagrams/sequence/sequenceDiagram.spec.js"

# Run Vitest tests with --root to specify vite config location
cd /app/src/packages/mermaid && npx vitest run --root /app/src src/diagrams/class/classDiagramGrammar.spec.ts src/diagrams/sequence/sequenceDiagram.spec.js --coverage false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
