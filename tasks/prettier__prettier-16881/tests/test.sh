#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/typescript/import-type/attributes/__snapshots__"
cp "/tests/format/typescript/import-type/attributes/__snapshots__/format.test.js.snap" "tests/format/typescript/import-type/attributes/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/import-type/attributes"
cp "/tests/format/typescript/import-type/attributes/format.test.js" "tests/format/typescript/import-type/attributes/format.test.js"
mkdir -p "tests/format/typescript/import-type/attributes"
cp "/tests/format/typescript/import-type/attributes/import-type-attributes.ts" "tests/format/typescript/import-type/attributes/import-type-attributes.ts"

# Run the specific format test for typescript/import-type/attributes
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
NODE_OPTIONS=--experimental-vm-modules yarn jest tests/format/typescript/import-type/attributes/format.test.js --runInBand --no-coverage
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
