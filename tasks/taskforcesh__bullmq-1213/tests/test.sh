#!/bin/bash

cd /app/src

# Start Redis server in the background
redis-server --daemonize yes --port 6379

# Wait for Redis to be ready
sleep 2

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests"
cp "/tests/test_worker.ts" "tests/test_worker.ts"

# Remove all other test files to ensure only our target tests run
cd tests && ls test_*.ts | grep -v -E "(test_worker.ts)" | xargs rm -f && cd ..

# Rebuild TypeScript after fix.patch is applied (Oracle agent applies it before running tests)
if yarn build 2>&1 | tee /tmp/build.log | grep -q "^src/.*: error TS"; then
  echo "TypeScript compilation failed with errors"
  test_status=1
else
  # Run TypeScript tests (only runs if build succeeded)
  NODE_ENV=test npx ts-mocha -p tsconfig-cjs.json --require ./mocha.setup.ts --spec tests/test_worker.ts --timeout 20000
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
