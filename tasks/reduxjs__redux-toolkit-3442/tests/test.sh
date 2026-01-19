#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/createAction.typetest.tsx" "packages/toolkit/src/tests/createAction.typetest.tsx"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/createSlice.typetest.ts" "packages/toolkit/src/tests/createSlice.typetest.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/serializableStateInvariantMiddleware.test.ts" "packages/toolkit/src/tests/serializableStateInvariantMiddleware.test.ts"

# Create a custom tsconfig for running only specific type tests
cd packages/toolkit
cat > tsconfig.custom.json << 'EOF'
{
  "extends": "./tsconfig.test.json",
  "compilerOptions": {
    "skipLibCheck": true
  },
  "include": [
    "src/tests/createAction.typetest.tsx",
    "src/tests/createSlice.typetest.ts"
  ]
}
EOF

# Run type tests using TypeScript compiler (for .typetest.* files)
yarn tsc -p tsconfig.custom.json --noEmit
test_status=$?

# Run regular unit test if type tests passed
if [ $test_status -eq 0 ]; then
  npx vitest run src/tests/serializableStateInvariantMiddleware.test.ts --no-coverage
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
