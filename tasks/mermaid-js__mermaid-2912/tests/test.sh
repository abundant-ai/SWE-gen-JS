#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/gantt.spec.js" "cypress/integration/rendering/gantt.spec.js"
mkdir -p "src/diagrams/gantt"
cp "/tests/src/diagrams/gantt/ganttDb.spec.js" "src/diagrams/gantt/ganttDb.spec.js"
mkdir -p "src/diagrams/gantt/parser"
cp "/tests/src/diagrams/gantt/parser/gantt.spec.js" "src/diagrams/gantt/parser/gantt.spec.js"
mkdir -p "src/diagrams/sequence"
cp "/tests/src/diagrams/sequence/sequenceDiagram.spec.js" "src/diagrams/sequence/sequenceDiagram.spec.js"

# Run Jest tests for the specific test files
npx jest src/diagrams/gantt/ganttDb.spec.js src/diagrams/gantt/parser/gantt.spec.js src/diagrams/sequence/sequenceDiagram.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
