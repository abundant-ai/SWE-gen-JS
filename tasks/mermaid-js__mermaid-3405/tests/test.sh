#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/diagrams/git"
cp "/tests/src/diagrams/git/gitGraphParserV2.spec.js" "src/diagrams/git/gitGraphParserV2.spec.js"

# Apply ESLint rules (the fix adds these rules to catch console.log usage)
# This ensures linting will fail if console.log statements are present
patch -p1 < /tests/eslint-rules.patch

# Run linter (should fail if console.log statements exist, pass if they're removed)
yarn run lint
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
