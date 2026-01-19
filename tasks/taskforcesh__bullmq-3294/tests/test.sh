#!/bin/bash

cd /app/src

# Start Redis server in the background
redis-server --daemonize yes --port 6379

# Wait for Redis to be ready
sleep 2

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "python/tests"
cp "/tests/python/tests/job_test.py" "python/tests/job_test.py"
mkdir -p "python/tests"
cp "/tests/python/tests/queue_test.py" "python/tests/queue_test.py"

# Rebuild TypeScript after fix.patch is applied (Oracle agent applies it before running tests)
yarn build

# Copy Lua scripts to Python module after rebuild
yarn run copy:lua:python

# Run Python tests using pytest
cd python
pytest -xvs tests/job_test.py tests/queue_test.py

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
