#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/classDiagram-v2.spec.js" "cypress/integration/rendering/classDiagram-v2.spec.js"
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/classDiagram.spec.js" "cypress/integration/rendering/classDiagram.spec.js"
mkdir -p "packages/mermaid/src/diagrams/class"
cp "/tests/packages/mermaid/src/diagrams/class/classDiagram.spec.js" "packages/mermaid/src/diagrams/class/classDiagram.spec.js"

# Run vitest on the specific test file (use --no-threads to reduce memory usage)
npx vitest run --no-threads packages/mermaid/src/diagrams/class/classDiagram.spec.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
