#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src"
cp "/tests/src/index.spec.ts" "src/index.spec.ts"
mkdir -p "tests/import-order"
cp "/tests/import-order/compiled.js" "tests/import-order/compiled.js"
mkdir -p "tests/import-order"
cp "/tests/import-order/compiled.ts" "tests/import-order/compiled.ts"
mkdir -p "tests/import-order"
cp "/tests/import-order/defined.d.ts" "tests/import-order/defined.d.ts"
mkdir -p "tests/import-order"
cp "/tests/import-order/defined.js" "tests/import-order/defined.js"
mkdir -p "tests/import-order"
cp "/tests/import-order/importer.ts" "tests/import-order/importer.ts"

# Reinstall dependencies if package.json or package-lock.json changed
npm install --legacy-peer-deps --ignore-scripts

# Patch create-merged-schema to handle network errors gracefully if it exists
if [ -f "scripts/create-merged-schema.ts" ]; then
    sed -i 's/^main();$/main().catch(() => { console.error("Schema merge failed, continuing..."); process.exit(0); });/' scripts/create-merged-schema.ts
fi

# Build must succeed - failing means fix is incomplete
if ! npm run build; then
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi

# Run the specific tests for this PR (import order and prefer-ts-exts feature)
npx mocha dist/index.spec.js -R spec --bail --grep "import.*before|prefer-ts-exts|ignore.*\.d\.ts"
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
