#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/bin"
cp "/tests/bin/eslint.js" "tests/bin/eslint.js"
mkdir -p "tests/fixtures/exit-on-fatal-error"
cp "/tests/fixtures/exit-on-fatal-error/fatal-error.js" "tests/fixtures/exit-on-fatal-error/fatal-error.js"
mkdir -p "tests/fixtures/exit-on-fatal-error"
cp "/tests/fixtures/exit-on-fatal-error/no-fatal-error-rule-violation.js" "tests/fixtures/exit-on-fatal-error/no-fatal-error-rule-violation.js"
mkdir -p "tests/fixtures/exit-on-fatal-error"
cp "/tests/fixtures/exit-on-fatal-error/no-fatal-error.js" "tests/fixtures/exit-on-fatal-error/no-fatal-error.js"
mkdir -p "tests/lib/cli-engine"
cp "/tests/lib/cli-engine/cli-engine.js" "tests/lib/cli-engine/cli-engine.js"
mkdir -p "tests/lib"
cp "/tests/lib/cli.js" "tests/lib/cli.js"
mkdir -p "tests/lib/eslint"
cp "/tests/lib/eslint/eslint.js" "tests/lib/eslint/eslint.js"

# Fix Node.js version compatibility issue in test (regex needs to handle both "Cannot read property" and "Cannot read properties")
sed -i "s|/Error while loading rule 'custom-rule': Cannot read property/u|/Error while loading rule 'custom-rule': Cannot read propert(y\|ies)/u|g" tests/lib/cli.js

# Run specific test files using mocha
npx mocha \
  tests/bin/eslint.js \
  tests/lib/cli-engine/cli-engine.js \
  tests/lib/cli.js \
  tests/lib/eslint/eslint.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
