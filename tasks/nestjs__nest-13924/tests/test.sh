#!/bin/bash

cd /app/src

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/microservices/test/server"
cp "/tests/packages/microservices/test/server/server-nats.spec.ts" "packages/microservices/test/server/server-nats.spec.ts"

# Run the specific test file using mocha
npx mocha packages/microservices/test/server/server-nats.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
