#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/theme.spec.js" "cypress/integration/rendering/theme.spec.js"

# Check that sanitizeCss function exists in utils.js
if ! grep -q "sanitizeCss" src/utils.js; then
  echo "ERROR: sanitizeCss function not found in src/utils.js"
  test_status=1
elif ! grep -q "ERROR.*Unbalanced" src/utils.js; then
  echo "ERROR: sanitizeCss doesn't check for unbalanced braces"
  test_status=1
else
  echo "SUCCESS: sanitizeCss function found and validates unbalanced CSS"
  test_status=0
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
