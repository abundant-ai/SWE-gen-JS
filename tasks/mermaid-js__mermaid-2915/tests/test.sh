#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/requirement.spec.js" "cypress/integration/rendering/requirement.spec.js"
mkdir -p "src/diagrams/requirement/parser"
cp "/tests/src/diagrams/requirement/parser/requirementDiagram.spec.js" "src/diagrams/requirement/parser/requirementDiagram.spec.js"

# Run Jest tests for the specific test files
npx jest src/diagrams/requirement/parser/requirementDiagram.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
