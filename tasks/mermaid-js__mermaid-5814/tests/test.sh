#!/bin/bash

cd /app/src

# Set environment variables for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/classDiagram-v2.spec.js" "cypress/integration/rendering/classDiagram-v2.spec.js"
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/classDiagram-v3.spec.js" "cypress/integration/rendering/classDiagram-v3.spec.js"
mkdir -p "packages/mermaid/src/diagrams/class"
cp "/tests/packages/mermaid/src/diagrams/class/classDiagram.spec.ts" "packages/mermaid/src/diagrams/class/classDiagram.spec.ts"

# Run vitest for the specific test files
pnpm exec vitest run packages/mermaid/src/diagrams/class/classDiagram.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
