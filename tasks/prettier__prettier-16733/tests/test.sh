#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/vue/event-binding/__snapshots__"
cp "/tests/format/vue/event-binding/__snapshots__/format.test.js.snap" "tests/format/vue/event-binding/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/vue/event-binding"
cp "/tests/format/vue/event-binding/non-ascii-expression-ts.vue" "tests/format/vue/event-binding/non-ascii-expression-ts.vue"
mkdir -p "tests/format/vue/event-binding"
cp "/tests/format/vue/event-binding/non-ascii-expression.vue" "tests/format/vue/event-binding/non-ascii-expression.vue"
mkdir -p "tests/format/vue/vue/__snapshots__"
cp "/tests/format/vue/vue/__snapshots__/format.test.js.snap" "tests/format/vue/vue/__snapshots__/format.test.js.snap"

# Run the specific format test for Vue event-binding
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

NODE_OPTIONS=--experimental-vm-modules yarn jest tests/format/vue/event-binding/format.test.js --runInBand --no-coverage
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
