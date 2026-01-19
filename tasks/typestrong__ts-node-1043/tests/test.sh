#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src"
cp "/tests/src/index.spec.ts" "src/index.spec.ts"

# Install any new dependencies from fix.patch (use --prefer-offline to avoid network issues)
npm install --legacy-peer-deps --ignore-scripts --prefer-offline

# Build TypeScript and schema
npm run build-nopack

# Create the packed tarball manually (avoid npm pack network issues)
mkdir -p tests/package
cp -r dist tests/package/
cp -r dist-raw tests/package/
cp -r register tests/package/
cp -r esm tests/package/ 2>/dev/null || true
cp esm.mjs tests/package/ 2>/dev/null || true
cp LICENSE tests/package/ 2>/dev/null || true
cp package.json tests/package/
cp tsconfig.schema.json tests/package/ 2>/dev/null || true
cp tsconfig.schemastore-schema.json tests/package/ 2>/dev/null || true
cd tests && tar -czf ts-node-packed.tgz -C package . && rm -rf package && cd ..

# Verify tarball exists
if [ ! -f tests/ts-node-packed.tgz ]; then
  echo "ERROR: ts-node-packed.tgz was not created"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Run coverage tests using nyc - this tests the coverage configuration
# The fix adds nyc.config.js and rewrite-coverage-paths.js
npx nyc mocha -- "dist/index.spec.js" -R spec --timeout 60000 --grep "should export the correct version" && node ./scripts/rewrite-coverage-paths.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
