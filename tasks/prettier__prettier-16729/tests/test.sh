#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/top-level-await/__snapshots__"
cp "/tests/format/js/top-level-await/__snapshots__/format.test.js.snap" "tests/format/js/top-level-await/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/top-level-await"
cp "/tests/format/js/top-level-await/test.cjs" "tests/format/js/top-level-await/test.cjs"
mkdir -p "tests/format/js/top-level-await"
cp "/tests/format/js/top-level-await/test.js" "tests/format/js/top-level-await/test.js"
mkdir -p "tests/format/js/top-level-await"
cp "/tests/format/js/top-level-await/test.mjs" "tests/format/js/top-level-await/test.mjs"
mkdir -p "tests/format/jsx/top-level-await/__snapshots__"
cp "/tests/format/jsx/top-level-await/__snapshots__/format.test.js.snap" "tests/format/jsx/top-level-await/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/jsx/top-level-await"
cp "/tests/format/jsx/top-level-await/format.test.js" "tests/format/jsx/top-level-await/format.test.js"
mkdir -p "tests/format/jsx/top-level-await"
cp "/tests/format/jsx/top-level-await/test.jsx" "tests/format/jsx/top-level-await/test.jsx"
mkdir -p "tests/format/typescript/top-level-await/__snapshots__"
cp "/tests/format/typescript/top-level-await/__snapshots__/format.test.js.snap" "tests/format/typescript/top-level-await/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/top-level-await"
cp "/tests/format/typescript/top-level-await/format.test.js" "tests/format/typescript/top-level-await/format.test.js"
mkdir -p "tests/format/typescript/top-level-await"
cp "/tests/format/typescript/top-level-await/test.cts" "tests/format/typescript/top-level-await/test.cts"
mkdir -p "tests/format/typescript/top-level-await"
cp "/tests/format/typescript/top-level-await/test.mts" "tests/format/typescript/top-level-await/test.mts"
mkdir -p "tests/format/typescript/top-level-await"
cp "/tests/format/typescript/top-level-await/test.ts" "tests/format/typescript/top-level-await/test.ts"
mkdir -p "tests/format/typescript/top-level-await"
cp "/tests/format/typescript/top-level-await/test.tsx" "tests/format/typescript/top-level-await/test.tsx"

# Run the specific format tests for top-level-await
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

NODE_OPTIONS=--experimental-vm-modules yarn jest tests/format/js/top-level-await/format.test.js tests/format/jsx/top-level-await/format.test.js tests/format/typescript/top-level-await/format.test.js --runInBand --no-coverage
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
