#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/erDiagram.spec.js" "cypress/integration/rendering/erDiagram.spec.js"
mkdir -p "src/diagrams/common"
cp "/tests/src/diagrams/common/common.spec.js" "src/diagrams/common/common.spec.js"
mkdir -p "src/diagrams/er/parser"
cp "/tests/src/diagrams/er/parser/erDiagram.spec.js" "src/diagrams/er/parser/erDiagram.spec.js"

# Run the Jest tests for the specific test files
npx jest src/diagrams/common/common.spec.js src/diagrams/er/parser/erDiagram.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
