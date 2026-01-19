#!/bin/bash

cd /app/src

# Start Redis server in the background
redis-server --daemonize yes --port 6379

# Wait for Redis to be ready
sleep 2

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "python/tests"
cp "/tests/python/tests/bulk_tests.py" "python/tests/bulk_tests.py"
mkdir -p "python/tests"
cp "/tests/python/tests/job_tests.py" "python/tests/job_tests.py"
mkdir -p "python/tests"
cp "/tests/python/tests/queue_tests.py" "python/tests/queue_tests.py"
mkdir -p "python/tests"
cp "/tests/python/tests/worker_tests.py" "python/tests/worker_tests.py"
mkdir -p "tests"
cp "/tests/test_flow.ts" "tests/test_flow.ts"

# Rebuild TypeScript after fix.patch is applied (Oracle agent applies it before running tests)
yarn build

# Copy Lua scripts to Python module after rebuild
yarn run copy:lua:python

# Run TypeScript tests using ts-mocha (matching CI test command pattern)
NODE_ENV=test npx ts-mocha -p tsconfig-cjs.json --require ./mocha.setup.ts tests/test_flow.ts --timeout 4000

ts_status=$?

if [ $ts_status -ne 0 ]; then
  test_status=$ts_status
else
  # Run Python tests using pytest
  cd python
  pytest -xvs tests/bulk_tests.py tests/job_tests.py tests/queue_tests.py tests/worker_tests.py
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
