#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/turbo-telemetry/src"
cp "/tests/packages/turbo-telemetry/src/config.test.ts" "packages/turbo-telemetry/src/config.test.ts"

# Run the specific test file using pnpm to use the project's jest configuration
cd packages/turbo-telemetry
pnpm test -- src/config.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
