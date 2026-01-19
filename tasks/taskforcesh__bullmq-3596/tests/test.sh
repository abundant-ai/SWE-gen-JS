#!/bin/bash

cd /app/src

# Start Redis server in the background
redis-server --daemonize yes --port 6379

# Wait for Redis to be ready
sleep 2

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests"
cp "/tests/test_worker.ts" "tests/test_worker.ts"

# Rebuild TypeScript after fix.patch is applied (Oracle agent applies it before running tests)
yarn build

# Run TypeScript tests using ts-mocha (without --config to run only specific file)
npx ts-mocha -p tsconfig-cjs.json --file ./mocha.setup.ts tests/test_worker.ts

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
