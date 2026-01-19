#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/diagrams/pie/parser"
cp "/tests/src/diagrams/pie/parser/pie.spec.js" "src/diagrams/pie/parser/pie.spec.js"

# Run Jest tests for the specific test file
npx jest src/diagrams/pie/parser/pie.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
