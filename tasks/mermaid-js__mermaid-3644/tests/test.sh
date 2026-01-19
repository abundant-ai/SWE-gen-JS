#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/stateDiagram-v2.spec.js" "cypress/integration/rendering/stateDiagram-v2.spec.js"
mkdir -p "packages/mermaid/src/diagrams/state/parser"
cp "/tests/packages/mermaid/src/diagrams/state/parser/state-style.spec.js" "packages/mermaid/src/diagrams/state/parser/state-style.spec.js"
mkdir -p "packages/mermaid/src/diagrams/state"
cp "/tests/packages/mermaid/src/diagrams/state/stateDb.spec.js" "packages/mermaid/src/diagrams/state/stateDb.spec.js"
mkdir -p "packages/mermaid/src/diagrams/state"
cp "/tests/packages/mermaid/src/diagrams/state/stateDiagram-v2.spec.js" "packages/mermaid/src/diagrams/state/stateDiagram-v2.spec.js"

# Run vitest on the specific test files (use --no-threads to reduce memory usage)
npx vitest run --no-threads packages/mermaid/src/diagrams/state/parser/state-style.spec.js packages/mermaid/src/diagrams/state/stateDb.spec.js packages/mermaid/src/diagrams/state/stateDiagram-v2.spec.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
