#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/diagrams/state"
cp "/tests/src/diagrams/state/stateDiagram-v2.spec.js" "src/diagrams/state/stateDiagram-v2.spec.js"
mkdir -p "src/diagrams/state"
cp "/tests/src/diagrams/state/stateDiagram.spec.js" "src/diagrams/state/stateDiagram.spec.js"

# Run Jest tests for the specific test files
npx jest src/diagrams/state/stateDiagram-v2.spec.js src/diagrams/state/stateDiagram.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
