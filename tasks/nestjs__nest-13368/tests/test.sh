#!/bin/bash

cd /app/src

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/microservices/e2e"
cp "/tests/integration/microservices/e2e/math-grpc.spec.ts" "integration/microservices/e2e/math-grpc.spec.ts"
mkdir -p "packages/microservices/test/server"
cp "/tests/packages/microservices/test/server/server-grpc.spec.ts" "packages/microservices/test/server/server-grpc.spec.ts"

# Run the specific test files using mocha
npx mocha integration/microservices/e2e/math-grpc.spec.ts packages/microservices/test/server/server-grpc.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
