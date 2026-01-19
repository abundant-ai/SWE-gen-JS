#!/bin/bash

cd /app/src

# Set environment variables for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/diagrams/flowchart"
cp "/tests/packages/mermaid/src/diagrams/flowchart/flowDb.spec.ts" "packages/mermaid/src/diagrams/flowchart/flowDb.spec.ts"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-arrows.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-arrows.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-comments.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-comments.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-direction.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-direction.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-edges.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-edges.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-huge.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-huge.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-interactions.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-interactions.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-lines.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-lines.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-md-string.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-md-string.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-node-data.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-node-data.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-singlenode.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-singlenode.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-text.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-text.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-vertice-chaining.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-vertice-chaining.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/subgraph.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/subgraph.spec.js"
mkdir -p "packages/mermaid/src"
cp "/tests/packages/mermaid/src/mermaidAPI.spec.ts" "packages/mermaid/src/mermaidAPI.spec.ts"

# Run vitest for the specific test files
pnpm exec vitest run \
  packages/mermaid/src/diagrams/flowchart/flowDb.spec.ts \
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
  packages/mermaid/src/diagrams/flowchart/parser/subgraph.spec.js \
  packages/mermaid/src/mermaidAPI.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
