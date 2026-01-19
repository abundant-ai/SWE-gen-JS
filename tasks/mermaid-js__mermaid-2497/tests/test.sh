#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/other"
cp "/tests/cypress/integration/other/xss.spec.js" "cypress/integration/other/xss.spec.js"

# Start dev server in background and run Cypress tests
yarn dev &
DEV_PID=$!

# Wait for dev server to be ready
echo "Waiting for dev server to start..."
for i in {1..30}; do
  if curl -s http://localhost:9000/ > /dev/null 2>&1; then
    echo "Dev server is ready!"
    break
  fi
  sleep 1
done

# Run the specific Cypress test
npx cypress run --spec "cypress/integration/other/xss.spec.js"
test_status=$?

# Kill dev server
kill $DEV_PID 2>/dev/null || true

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
