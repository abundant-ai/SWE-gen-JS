#!/bin/bash

cd /app/src

# Set environment variables for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/flowchart-v2.spec.js" "cypress/integration/rendering/flowchart-v2.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-arrows.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-arrows.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-comments.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-comments.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-direction.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-direction.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-edges.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-edges.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-huge.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-huge.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-interactions.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-interactions.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-lines.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-lines.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-md-string.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-md-string.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-node-data.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-node-data.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-singlenode.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-singlenode.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-text.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-text.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-vertice-chaining.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-vertice-chaining.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow.spec.js"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/subgraph.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/subgraph.spec.js"

# Run vitest for the specific test files (excluding cypress e2e tests)
pnpm exec vitest run \
  packages/mermaid/src/diagrams/flowchart/parser/flow-arrows.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-comments.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-direction.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-edges.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-huge.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-interactions.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-lines.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-md-string.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-node-data.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-singlenode.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-text.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow-vertice-chaining.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/flow.spec.js \
  packages/mermaid/src/diagrams/flowchart/parser/subgraph.spec.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
