#!/bin/bash

cd /app/src

# Set environment variables for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/journey.spec.js" "cypress/integration/rendering/journey.spec.js"

# Start dev server in background
pnpm run dev &
DEV_SERVER_PID=$!

# Wait for server to be ready
echo "Waiting for dev server to start..."
timeout 60 bash -c 'until curl -s http://localhost:9000 > /dev/null; do sleep 1; done' || {
  echo "Dev server failed to start"
  kill $DEV_SERVER_PID 2>/dev/null || true
  exit 1
}
echo "Dev server is ready"

# Run cypress test for the specific test file
pnpm exec cypress run --spec cypress/integration/rendering/journey.spec.js
test_status=$?

# Kill dev server
kill $DEV_SERVER_PID 2>/dev/null || true

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
