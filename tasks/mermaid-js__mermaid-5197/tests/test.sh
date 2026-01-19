#!/bin/bash

cd /app/src

# For a revert PR, the goal is to remove the buggy feature
# At BASE: buggy feature exists - FAIL (reward=0)
# At HEAD: feature removed - PASS (reward=1)

# Check if the subGraphTitleMargins implementation file exists
if [ -f "packages/mermaid/src/utils/subGraphTitleMargins.ts" ]; then
  # Feature still exists - this means the buggy code is present
  # FAIL: we want the feature to be removed
  test_status=1
else
  # Feature has been removed - this is the correct state
  # PASS: the revert worked correctly
  test_status=0
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
