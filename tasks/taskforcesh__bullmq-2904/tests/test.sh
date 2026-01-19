#!/bin/bash

cd /app/src

# Start Redis server in the background
redis-server --daemonize yes --port 6379

# Wait for Redis to be ready
sleep 2

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests"
cp "/tests/test_bulk.ts" "tests/test_bulk.ts"

# Rebuild TypeScript after fix.patch is applied (Oracle agent applies it before running tests)
yarn build

# Copy Lua scripts to Python module after rebuild
yarn run copy:lua:python

# Run TypeScript tests using ts-mocha (matching CI test command pattern)
# Note: We need to explicitly require mocha.setup.ts and NOT use --config ./.mocharc.js
# because .mocharc.js has spec: ['./tests/test_*.ts'] which would run ALL tests
NODE_ENV=test npx ts-mocha -p tsconfig-cjs.json --require ./mocha.setup.ts tests/test_bulk.ts --timeout 4000

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
