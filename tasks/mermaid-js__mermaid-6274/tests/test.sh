#!/bin/bash

cd /app/src

# Set environment variables for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/journey.spec.js" "cypress/integration/rendering/journey.spec.js"

# Run cypress tests for the specific test file using start-server-and-test
pnpm exec start-server-and-test dev http://localhost:9000 "cypress run --spec cypress/integration/rendering/journey.spec.js"
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
