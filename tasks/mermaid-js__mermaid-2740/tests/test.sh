#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/flowchart-v2.spec.js" "cypress/integration/rendering/flowchart-v2.spec.js"
mkdir -p "src/diagrams/flowchart/parser"
cp "/tests/src/diagrams/flowchart/parser/flow-singlenode.spec.js" "src/diagrams/flowchart/parser/flow-singlenode.spec.js"

# Run Jest tests for the specific test file (non-cypress test)
npx jest src/diagrams/flowchart/parser/flow-singlenode.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
