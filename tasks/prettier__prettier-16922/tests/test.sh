#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/angular/icu-expression/__snapshots__"
cp "/tests/format/angular/icu-expression/__snapshots__/format.test.js.snap" "tests/format/angular/icu-expression/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/angular/icu-expression"
cp "/tests/format/angular/icu-expression/issue-16914.html" "tests/format/angular/icu-expression/issue-16914.html"

# Run the specific format test for angular/icu-expression
# Temporarily rename jest.config.js to avoid top-level await issues and create minimal config
mv jest.config.js jest.config.js.bak

# Create minimal jest config that avoids esm-utils but includes necessary setup
cat > jest.config.js << 'EOF'
export default {
  setupFiles: [
    "<rootDir>/tests/config/format-test-setup.js",
    "<rootDir>/tests/integration/integration-test-setup.js",
  ],
  runner: "jest-light-runner",
  snapshotSerializers: [
    "jest-snapshot-serializer-raw",
    "jest-snapshot-serializer-ansi",
  ],
  transform: {},
};
EOF

# Set environment variables that jest.config.js normally sets
export PRETTIER_DIR=/app/src
export PRETTIER_INSTALLED_DIR=""

# Run jest
NODE_OPTIONS=--experimental-vm-modules yarn jest tests/format/angular/icu-expression/format.test.js --runInBand --no-coverage
test_status=$?

# Restore original jest.config.js
rm jest.config.js
mv jest.config.js.bak jest.config.js

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
