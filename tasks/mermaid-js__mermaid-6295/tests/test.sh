#!/bin/bash

cd /app/src

# Set environment variables for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/diagrams/state"
cp "/tests/packages/mermaid/src/diagrams/state/stateDiagram-v2.spec.js" "packages/mermaid/src/diagrams/state/stateDiagram-v2.spec.js"

# Run vitest for the specific test file
pnpm exec vitest run packages/mermaid/src/diagrams/state/stateDiagram-v2.spec.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
