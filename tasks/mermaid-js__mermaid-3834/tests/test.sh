#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid-mindmap/src"
cp "/tests/packages/mermaid-mindmap/src/mindmap.spec.js" "packages/mermaid-mindmap/src/mindmap.spec.js"

# Run vitest on the specific test file (use --no-threads to reduce memory usage)
npx vitest run --no-threads packages/mermaid-mindmap/src/mindmap.spec.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
