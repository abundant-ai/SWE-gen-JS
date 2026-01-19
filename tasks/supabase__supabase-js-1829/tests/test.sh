#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/realtime-js/test"
cp "/tests/packages/core/realtime-js/test/RealtimeClient.config.test.ts" "packages/core/realtime-js/test/RealtimeClient.config.test.ts"
mkdir -p "packages/core/realtime-js/test"
cp "/tests/packages/core/realtime-js/test/RealtimeClient.transport.test.ts" "packages/core/realtime-js/test/RealtimeClient.transport.test.ts"
mkdir -p "packages/core/realtime-js/test"
cp "/tests/packages/core/realtime-js/test/serializer.test.ts" "packages/core/realtime-js/test/serializer.test.ts"

# Run specific test files from the realtime-js package directory
cd packages/core/realtime-js
npx vitest run test/RealtimeClient.config.test.ts test/RealtimeClient.transport.test.ts test/serializer.test.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
