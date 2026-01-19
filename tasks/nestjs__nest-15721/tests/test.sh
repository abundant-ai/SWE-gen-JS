#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test/router"
cp "/tests/packages/core/test/router/router-response-controller.spec.ts" "packages/core/test/router/router-response-controller.spec.ts"
mkdir -p "packages/core/test/router"
cp "/tests/packages/core/test/router/sse-stream.spec.ts" "packages/core/test/router/sse-stream.spec.ts"

# Run the specific test files using mocha
npx mocha packages/core/test/router/router-response-controller.spec.ts packages/core/test/router/sse-stream.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
