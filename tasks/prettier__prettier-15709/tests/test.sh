#!/bin/bash

cd /app/src

# Reinstall dependencies and rebuild (agent may have modified package.json/yarn.lock)
# This ensures dist/ reflects any patches applied by oracle agent
yarn install --immutable 2>&1 | tail -5
yarn build 2>&1 | tail -5

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/cursor/__snapshots__"
cp "/tests/format/js/cursor/__snapshots__/format.test.js.snap" "tests/format/js/cursor/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/cursor"
cp "/tests/format/js/cursor/cursor-11.js" "tests/format/js/cursor/cursor-11.js"
mkdir -p "tests/format/jsx/cursor/__snapshots__"
cp "/tests/format/jsx/cursor/__snapshots__/format.test.js.snap" "tests/format/jsx/cursor/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/jsx/cursor"
cp "/tests/format/jsx/cursor/after-last-jsx-text.js" "tests/format/jsx/cursor/after-last-jsx-text.js"
mkdir -p "tests/format/jsx/cursor"
cp "/tests/format/jsx/cursor/after-tag.js" "tests/format/jsx/cursor/after-tag.js"
mkdir -p "tests/format/jsx/cursor"
cp "/tests/format/jsx/cursor/before-first-jsx-text.js" "tests/format/jsx/cursor/before-first-jsx-text.js"
mkdir -p "tests/format/jsx/cursor"
cp "/tests/format/jsx/cursor/before-tag.js" "tests/format/jsx/cursor/before-tag.js"
mkdir -p "tests/format/jsx/cursor"
cp "/tests/format/jsx/cursor/in-jsx-text.js" "tests/format/jsx/cursor/in-jsx-text.js"
mkdir -p "tests/format/jsx/cursor"
cp "/tests/format/jsx/cursor/in-tag.js" "tests/format/jsx/cursor/in-tag.js"
mkdir -p "tests/unit"
cp "/tests/unit/print-doc-to-string.js" "tests/unit/print-doc-to-string.js"

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
  moduleNameMapper: {
    "prettier-local": "<rootDir>/tests/config/prettier-entry.js",
    "prettier-standalone": "<rootDir>/tests/config/require-standalone.cjs",
  },
  transform: {},
};
EOF

# Set environment variables that jest.config.js normally sets
export PRETTIER_DIR=/app/src
export PRETTIER_INSTALLED_DIR=""

# Run the specific format tests for cursor functionality and the unit test
NODE_OPTIONS=--experimental-vm-modules yarn jest tests/format/js/cursor/format.test.js tests/format/jsx/cursor/format.test.js tests/unit/print-doc-to-string.js --runInBand --no-coverage
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
