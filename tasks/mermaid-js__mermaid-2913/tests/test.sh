#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/diagrams/flowchart/parser"
cp "/tests/src/diagrams/flowchart/parser/flow.spec.js" "src/diagrams/flowchart/parser/flow.spec.js"

# Run Jest tests for the specific test files
npx jest src/diagrams/flowchart/parser/flow.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
