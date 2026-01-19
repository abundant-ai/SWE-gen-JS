#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/diagrams/sequence"
cp "/tests/src/diagrams/sequence/sequenceDiagram.spec.js" "src/diagrams/sequence/sequenceDiagram.spec.js"

# Run Jest unit test
npx jest src/diagrams/sequence/sequenceDiagram.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
