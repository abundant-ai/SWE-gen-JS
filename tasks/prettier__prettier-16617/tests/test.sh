#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/scss/comments/__snapshots__"
cp "/tests/format/scss/comments/__snapshots__/format.test.js.snap" "tests/format/scss/comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/scss/scss/__snapshots__"
cp "/tests/format/scss/scss/__snapshots__/format.test.js.snap" "tests/format/scss/scss/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/scss/trailing-comma/__snapshots__"
cp "/tests/format/scss/trailing-comma/__snapshots__/format.test.js.snap" "tests/format/scss/trailing-comma/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/scss/trailing-comma"
cp "/tests/format/scss/trailing-comma/comments.scss" "tests/format/scss/trailing-comma/comments.scss"
mkdir -p "tests/format/scss/trailing-comma"
cp "/tests/format/scss/trailing-comma/issue-6920.scss" "tests/format/scss/trailing-comma/issue-6920.scss"
mkdir -p "tests/format/scss/trailing-comma"
cp "/tests/format/scss/trailing-comma/trailing-comma.scss" "tests/format/scss/trailing-comma/trailing-comma.scss"

# Run the specific format tests
# Temporarily rename jest.config.js to avoid top-level await issues and create minimal config
mv jest.config.js jest.config.js.bak

# Create minimal jest config for format tests
cat > jest.config.js << 'EOF'
export default {
  setupFiles: [
    "<rootDir>/tests/config/format-test-setup.js",
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

NODE_OPTIONS=--experimental-vm-modules yarn jest tests/format/scss/trailing-comma/format.test.js --runInBand --no-coverage
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
