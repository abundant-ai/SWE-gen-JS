#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-new-native-nonconstructor.js" "tests/lib/rules/no-new-native-nonconstructor.js"

# Run the specific test files for this PR
npx mocha tests/lib/rules/no-new-native-nonconstructor.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
