#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/erDiagram.spec.js" "cypress/integration/rendering/erDiagram.spec.js"
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/errorDiagram.spec.js" "cypress/integration/rendering/errorDiagram.spec.js"

# Run Cypress tests with dev server using start-server-and-test
npx start-server-and-test dev http://localhost:9000/ "cypress run --spec 'cypress/integration/rendering/erDiagram.spec.js,cypress/integration/rendering/errorDiagram.spec.js'"
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
