#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/microservices/e2e"
cp "/tests/integration/microservices/e2e/fanout-exchange-rmq.spec.ts" "integration/microservices/e2e/fanout-exchange-rmq.spec.ts"
mkdir -p "packages/microservices/test/client"
cp "/tests/packages/microservices/test/client/client-rmq.spec.ts" "packages/microservices/test/client/client-rmq.spec.ts"
mkdir -p "packages/microservices/test/server"
cp "/tests/packages/microservices/test/server/server-rmq.spec.ts" "packages/microservices/test/server/server-rmq.spec.ts"

# Run the specific unit test files using mocha
# Note: Skipping integration test that requires RabbitMQ server
npx mocha packages/microservices/test/client/client-rmq.spec.ts packages/microservices/test/server/server-rmq.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
