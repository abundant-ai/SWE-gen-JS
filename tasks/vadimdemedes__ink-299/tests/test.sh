#!/bin/bash

cd /app/src

# Set environment variables (from CI config)
export FORCE_COLOR=true
export CI=false
export TS_NODE_TRANSPILE_ONLY=true

# Define global.self for react-devtools-core compatibility (required by src/devtools.ts)
export NODE_OPTIONS="--require ${PWD}/define-self.js"
cat > define-self.js << 'EOF'
if (!global.self) {
  global.self = global;
}
EOF

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/components.tsx" "test/components.tsx"
mkdir -p "test"
cp "/tests/deprecated.tsx" "test/deprecated.tsx"
mkdir -p "test"
cp "/tests/display.tsx" "test/display.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/ci.tsx" "test/fixtures/ci.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit-double-raw-mode.tsx" "test/fixtures/exit-double-raw-mode.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit-normally.tsx" "test/fixtures/exit-normally.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit-on-exit-with-error.tsx" "test/fixtures/exit-on-exit-with-error.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit-on-exit.tsx" "test/fixtures/exit-on-exit.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit-on-finish.tsx" "test/fixtures/exit-on-finish.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit-on-unmount.tsx" "test/fixtures/exit-on-unmount.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit-raw-on-exit-with-error.tsx" "test/fixtures/exit-raw-on-exit-with-error.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit-raw-on-exit.tsx" "test/fixtures/exit-raw-on-exit.tsx"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit-raw-on-unmount.tsx" "test/fixtures/exit-raw-on-unmount.tsx"
mkdir -p "test"
cp "/tests/flex-align-items.tsx" "test/flex-align-items.tsx"
mkdir -p "test"
cp "/tests/flex-align-self.tsx" "test/flex-align-self.tsx"
mkdir -p "test"
cp "/tests/flex-direction.tsx" "test/flex-direction.tsx"
mkdir -p "test"
cp "/tests/flex-justify-content.tsx" "test/flex-justify-content.tsx"
mkdir -p "test"
cp "/tests/flex.tsx" "test/flex.tsx"
mkdir -p "test"
cp "/tests/margin.tsx" "test/margin.tsx"
mkdir -p "test"
cp "/tests/padding.tsx" "test/padding.tsx"

# Rebuild TypeScript project to pick up any changes (e.g., if Oracle applied fix.patch)
# Need to allow errors due to incompatible dependency types (undici-types, @types/lodash with TS 3.8.3)
cp tsconfig.json tsconfig.json.backup
node -e "const fs=require('fs'); const cfg=JSON.parse(fs.readFileSync('tsconfig.json')); cfg.compilerOptions.noEmitOnError=false; cfg.compilerOptions.skipLibCheck=true; fs.writeFileSync('tsconfig.json', JSON.stringify(cfg, null, '\t'));"
npm run build || true
mv tsconfig.json.backup tsconfig.json

# Run AVA tests for the specific test files
npx ava test/components.tsx test/deprecated.tsx test/display.tsx test/fixtures/ci.tsx test/fixtures/exit-double-raw-mode.tsx test/fixtures/exit-normally.tsx test/fixtures/exit-on-exit-with-error.tsx test/fixtures/exit-on-exit.tsx test/fixtures/exit-on-finish.tsx test/fixtures/exit-on-unmount.tsx test/fixtures/exit-raw-on-exit-with-error.tsx test/fixtures/exit-raw-on-exit.tsx test/fixtures/exit-raw-on-unmount.tsx test/flex-align-items.tsx test/flex-align-self.tsx test/flex-direction.tsx test/flex-justify-content.tsx test/flex.tsx test/margin.tsx test/padding.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
