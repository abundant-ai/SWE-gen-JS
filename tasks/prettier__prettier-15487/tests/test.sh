#!/bin/bash

cd /app/src

# Reinstall dependencies and rebuild (agent may have modified package.json/yarn.lock)
# This ensures dist/ reflects any patches applied by oracle agent
yarn install --immutable 2>&1 | tail -5
yarn build 2>&1 | tail -5

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/babel-plugins/__snapshots__"
cp "/tests/format/js/babel-plugins/__snapshots__/jsfmt.spec.js.snap" "tests/format/js/babel-plugins/__snapshots__/jsfmt.spec.js.snap"
mkdir -p "tests/format/js/babel-plugins"
cp "/tests/format/js/babel-plugins/deferred-import-evaluation.js" "tests/format/js/babel-plugins/deferred-import-evaluation.js"
mkdir -p "tests/format/js/babel-plugins"
cp "/tests/format/js/babel-plugins/jsfmt.spec.js" "tests/format/js/babel-plugins/jsfmt.spec.js"
mkdir -p "tests/format/js/babel-plugins"
cp "/tests/format/js/babel-plugins/source-phase-imports.js" "tests/format/js/babel-plugins/source-phase-imports.js"
mkdir -p "tests/format/js/deferred-import-evaluation/__snapshots__"
cp "/tests/format/js/deferred-import-evaluation/__snapshots__/jsfmt.spec.js.snap" "tests/format/js/deferred-import-evaluation/__snapshots__/jsfmt.spec.js.snap"
mkdir -p "tests/format/js/deferred-import-evaluation"
cp "/tests/format/js/deferred-import-evaluation/import-defer-attributes-declaration.js" "tests/format/js/deferred-import-evaluation/import-defer-attributes-declaration.js"
mkdir -p "tests/format/js/deferred-import-evaluation"
cp "/tests/format/js/deferred-import-evaluation/import-defer.js" "tests/format/js/deferred-import-evaluation/import-defer.js"
mkdir -p "tests/format/js/deferred-import-evaluation"
cp "/tests/format/js/deferred-import-evaluation/jsfmt.spec.js" "tests/format/js/deferred-import-evaluation/jsfmt.spec.js"
mkdir -p "tests/format/js/deferred-import-evaluation"
cp "/tests/format/js/deferred-import-evaluation/no-default.js" "tests/format/js/deferred-import-evaluation/no-default.js"
mkdir -p "tests/format/js/deferred-import-evaluation"
cp "/tests/format/js/deferred-import-evaluation/no-named.js" "tests/format/js/deferred-import-evaluation/no-named.js"
mkdir -p "tests/format/js/source-phase-imports/__snapshots__"
cp "/tests/format/js/source-phase-imports/__snapshots__/jsfmt.spec.js.snap" "tests/format/js/source-phase-imports/__snapshots__/jsfmt.spec.js.snap"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/default-binding.js" "tests/format/js/source-phase-imports/default-binding.js"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/import-source-attributes-declaration.js" "tests/format/js/source-phase-imports/import-source-attributes-declaration.js"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/import-source-attributes-expression.js" "tests/format/js/source-phase-imports/import-source-attributes-expression.js"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/import-source-binding-from.js" "tests/format/js/source-phase-imports/import-source-binding-from.js"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/import-source-binding-source.js" "tests/format/js/source-phase-imports/import-source-binding-source.js"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/import-source-dynamic-import.js" "tests/format/js/source-phase-imports/import-source-dynamic-import.js"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/import-source.js" "tests/format/js/source-phase-imports/import-source.js"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/jsfmt.spec.js" "tests/format/js/source-phase-imports/jsfmt.spec.js"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/no-named.js" "tests/format/js/source-phase-imports/no-named.js"
mkdir -p "tests/format/js/source-phase-imports"
cp "/tests/format/js/source-phase-imports/no-namespace.js" "tests/format/js/source-phase-imports/no-namespace.js"
mkdir -p "tests/format/misc/errors/js/import/__snapshots__"
cp "/tests/format/misc/errors/js/import/__snapshots__/jsfmt.spec.js.snap" "tests/format/misc/errors/js/import/__snapshots__/jsfmt.spec.js.snap"

# Temporarily rename jest.config.js to avoid top-level await issues and create minimal config
mv jest.config.js jest.config.js.bak

# Create minimal jest config for format tests
cat > jest.config.js << 'EOF'
export default {
  testMatch: [
    "<rootDir>/tests/format/**/jsfmt.spec.js",
  ],
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
  modulePathIgnorePatterns: [
    "<rootDir>/dist",
    "<rootDir>/website",
    "<rootDir>/scripts/release",
  ],
  transform: {},
};
EOF

# Set environment variables that jest.config.js normally sets
export PRETTIER_DIR=/app/src
export PRETTIER_INSTALLED_DIR=""

# Run the specific format tests for this PR
NODE_OPTIONS=--experimental-vm-modules yarn jest \
  tests/format/js/babel-plugins/jsfmt.spec.js \
  tests/format/js/deferred-import-evaluation/jsfmt.spec.js \
  tests/format/js/source-phase-imports/jsfmt.spec.js \
  tests/format/misc/errors/js/import/jsfmt.spec.js \
  --runInBand --no-coverage
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
