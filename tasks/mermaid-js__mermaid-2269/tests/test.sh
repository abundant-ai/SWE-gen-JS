#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/classDiagram-v2.spec.js" "cypress/integration/rendering/classDiagram-v2.spec.js"
mkdir -p "src/diagrams/class"
cp "/tests/src/diagrams/class/svgDraw.spec.js" "src/diagrams/class/svgDraw.spec.js"

# Run Jest unit test for the specific file
npx jest src/diagrams/class/svgDraw.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
