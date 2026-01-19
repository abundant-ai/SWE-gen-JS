#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/diagrams/flowchart"
cp "/tests/packages/mermaid/src/diagrams/flowchart/flowDb.spec.js" "packages/mermaid/src/diagrams/flowchart/flowDb.spec.js"
mkdir -p "packages/mermaid/src/diagrams/flowchart/parser"
cp "/tests/packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js" "packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js"

# Run vitest on the specific test files (use --no-threads to reduce memory usage)
npx vitest run --no-threads packages/mermaid/src/diagrams/flowchart/flowDb.spec.js packages/mermaid/src/diagrams/flowchart/parser/flow-style.spec.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
