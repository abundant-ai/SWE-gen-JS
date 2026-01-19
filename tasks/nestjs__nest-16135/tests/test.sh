#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/hello-world/e2e"
cp "/tests/integration/hello-world/e2e/middleware-fastify.spec.ts" "integration/hello-world/e2e/middleware-fastify.spec.ts"

# Run the specific test file using mocha
npx mocha integration/hello-world/e2e/middleware-fastify.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
