#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/gitGraph.spec.js" "cypress/integration/rendering/gitGraph.spec.js"
mkdir -p "src/diagrams/git"
cp "/tests/src/diagrams/git/gitGraphParserV2.spec.js" "src/diagrams/git/gitGraphParserV2.spec.js"

# Run the Jest test (gitGraphParserV2.spec.js)
npx jest src/diagrams/git/gitGraphParserV2.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
