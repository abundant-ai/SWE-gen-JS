#!/bin/bash

cd /app/src

# Start Redis server in the background
redis-server --daemonize yes --port 6379

# Wait for Redis to be ready
sleep 2

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "python/tests"
cp "/tests/python/tests/deduplication_test.py" "python/tests/deduplication_test.py"

# Run Python tests
cd /app/src/python
pytest -xvs tests/deduplication_test.py

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
