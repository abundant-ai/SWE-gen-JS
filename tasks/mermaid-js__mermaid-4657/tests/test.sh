#!/bin/bash

cd /app/src

# Environment variables already set in Dockerfile (CI=true)

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/flowchart.spec.js" "cypress/integration/rendering/flowchart.spec.js"
mkdir -p "packages/mermaid/src"
cp "/tests/packages/mermaid/src/diagram.spec.ts" "packages/mermaid/src/diagram.spec.ts"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-edges.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-edges.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-md-string.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-md-string.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-singlenode.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-singlenode.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-text.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-text.spec.js"

# Run Vitest test for the specific test files
npx vitest run \
  packages/mermaid/src/diagram.spec.ts \
  packages/mermaid/src/diagrams/flowchart/parser/flow-edges.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-md-string.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-singlenode.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-text.spec.js \
  --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
