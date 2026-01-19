#!/bin/bash

cd /app/src

# Set environment variables for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/diagrams/state/parser"
cp "/tests/packages/mermaid/src/diagrams/state/parser/state-parser.spec.js" "packages/mermaid/src/diagrams/state/parser/state-parser.spec.js"
mkdir -p "packages/mermaid/src/diagrams/state/parser"
cp "/tests/packages/mermaid/src/diagrams/state/parser/state-style.spec.js" "packages/mermaid/src/diagrams/state/parser/state-style.spec.js"
mkdir -p "packages/mermaid/src/diagrams/state"
cp "/tests/packages/mermaid/src/diagrams/state/stateDb.spec.js" "packages/mermaid/src/diagrams/state/stateDb.spec.js"
mkdir -p "packages/mermaid/src/diagrams/state"
cp "/tests/packages/mermaid/src/diagrams/state/stateDiagram-v2.spec.js" "packages/mermaid/src/diagrams/state/stateDiagram-v2.spec.js"
mkdir -p "packages/mermaid/src/diagrams/state"
cp "/tests/packages/mermaid/src/diagrams/state/stateDiagram.spec.js" "packages/mermaid/src/diagrams/state/stateDiagram.spec.js"
mkdir -p "packages/mermaid/src"
cp "/tests/packages/mermaid/src/mermaidAPI.spec.ts" "packages/mermaid/src/mermaidAPI.spec.ts"

# Run vitest for the specific test files
pnpm exec vitest run \
  packages/mermaid/src/diagrams/state/parser/state-parser.spec.js \
  packages/mermaid/src/diagrams/state/parser/state-style.spec.js \
  packages/mermaid/src/diagrams/state/stateDb.spec.js \
  packages/mermaid/src/diagrams/state/stateDiagram-v2.spec.js \
  packages/mermaid/src/diagrams/state/stateDiagram.spec.js \
  packages/mermaid/src/mermaidAPI.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
