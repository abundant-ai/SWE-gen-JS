#!/bin/bash

cd /app/src

# Start Redis server in the background
redis-server --daemonize yes --port 6379

# Wait for Redis to be ready
sleep 2

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests"
cp "/tests/test_flow.ts" "tests/test_flow.ts"

# Remove all other test files to ensure only our target tests run
cd tests && ls test_*.ts | grep -v -E "(test_flow.ts)" | xargs rm -f && cd ..

# Rebuild TypeScript after fix.patch is applied (Oracle agent applies it before running tests)
yarn build

# Run TypeScript tests using ts-mocha (matching CI test command pattern)
# Explicitly use --spec to override .mocharc.js spec pattern
NODE_ENV=test npx ts-mocha -p tsconfig-cjs.json --require ./mocha.setup.ts --spec tests/test_flow.ts --timeout 20000

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
