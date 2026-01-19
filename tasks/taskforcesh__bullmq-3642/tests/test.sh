#!/bin/bash

cd /app/src

# Start Redis server in the background
redis-server --daemonize yes --port 6379

# Wait for Redis to be ready
sleep 2

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "elixir/test/bullmq"
cp "/tests/elixir/test/bullmq/worker_cancellation_test.exs" "elixir/test/bullmq/worker_cancellation_test.exs"
mkdir -p "python/tests"
cp "/tests/python/tests/bulk_test.py" "python/tests/bulk_test.py"
mkdir -p "python/tests"
cp "/tests/python/tests/deduplication_test.py" "python/tests/deduplication_test.py"
mkdir -p "python/tests"
cp "/tests/python/tests/delay_test.py" "python/tests/delay_test.py"
mkdir -p "python/tests"
cp "/tests/python/tests/flow_test.py" "python/tests/flow_test.py"
mkdir -p "python/tests"
cp "/tests/python/tests/job_test.py" "python/tests/job_test.py"
mkdir -p "python/tests"
cp "/tests/python/tests/queue_test.py" "python/tests/queue_test.py"
mkdir -p "python/tests"
cp "/tests/python/tests/worker_test.py" "python/tests/worker_test.py"

# Run Python tests
cd /app/src/python
pytest -xvs \
  tests/bulk_test.py \
  tests/deduplication_test.py \
  tests/delay_test.py \
  tests/flow_test.py \
  tests/job_test.py \
  tests/queue_test.py \
  tests/worker_test.py

python_status=$?

# Run Elixir tests
cd /app/src/elixir
mix test test/bullmq/worker_cancellation_test.exs

elixir_status=$?

# Overall test status - fail if either failed
test_status=0
if [ $python_status -ne 0 ] || [ $elixir_status -ne 0 ]; then
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
