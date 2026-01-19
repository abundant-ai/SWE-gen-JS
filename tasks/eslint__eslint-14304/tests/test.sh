#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/init"
cp "/tests/lib/init/config-initializer.js" "tests/lib/init/config-initializer.js"

# Run specific test file using mocha with increased timeout
npx mocha --timeout 10000 \
  tests/lib/init/config-initializer.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
