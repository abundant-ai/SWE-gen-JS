#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/jsx/text-wrap/__snapshots__"
cp "/tests/format/jsx/text-wrap/__snapshots__/format.test.js.snap" "tests/format/jsx/text-wrap/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/jsx/text-wrap"
cp "/tests/format/jsx/text-wrap/test.js" "tests/format/jsx/text-wrap/test.js"
mkdir -p "tests/format/mdx/mdx/__snapshots__"
cp "/tests/format/mdx/mdx/__snapshots__/format.test.js.snap" "tests/format/mdx/mdx/__snapshots__/format.test.js.snap"
mkdir -p "tests/unit"
cp "/tests/unit/doc-builders.js" "tests/unit/doc-builders.js"
mkdir -p "tests/unit"
cp "/tests/unit/is-empty-doc.js" "tests/unit/is-empty-doc.js"

# Run the specific format and unit tests
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

NODE_OPTIONS=--experimental-vm-modules yarn jest tests/format/jsx/text-wrap/format.test.js tests/format/mdx/mdx/format.test.js tests/unit/doc-builders.js tests/unit/is-empty-doc.js --runInBand --no-coverage
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
