#!/bin/bash

cd /app/src

# Environment variables already set in Dockerfile (CI=true)

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/other"
cp "/tests/cypress/integration/other/configuration.spec.js" "cypress/integration/other/configuration.spec.js"

# Start dev server and run Cypress test using start-server-and-test
npx start-server-and-test "pnpm run dev:vite" http://localhost:9000/ "npx cypress run --spec cypress/integration/other/configuration.spec.js"
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
