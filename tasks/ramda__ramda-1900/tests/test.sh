#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/lift.js" "test/lift.js"
mkdir -p "test"
cp "/tests/liftN.js" "test/liftN.js"
mkdir -p "test/shared"
cp "/tests/shared/Id.js" "test/shared/Id.js"
mkdir -p "test/shared"
cp "/tests/shared/Maybe.js" "test/shared/Maybe.js"
mkdir -p "test"
cp "/tests/unnest.js" "test/unnest.js"

# Run Mocha on the specific test files
npx mocha --reporter spec test/lift.js test/liftN.js test/shared/Id.js test/shared/Maybe.js test/unnest.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
