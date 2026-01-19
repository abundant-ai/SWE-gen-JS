#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cli/internal/daemonclient"
cp "/tests/cli/internal/daemonclient/daemonclient_test.go" "cli/internal/daemonclient/daemonclient_test.go"

# Run the specific Go test for daemonclient package
cd cli && go test -v ./internal/daemonclient/...
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
