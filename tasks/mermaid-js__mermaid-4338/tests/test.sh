#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/diagrams/class"
cp "/tests/packages/mermaid/src/diagrams/class/classDiagramGrammar.spec.ts" "packages/mermaid/src/diagrams/class/classDiagramGrammar.spec.ts"
mkdir -p "packages/mermaid/src/diagrams/class"
cp "/tests/packages/mermaid/src/diagrams/class/classParser.spec.ts" "packages/mermaid/src/diagrams/class/classParser.spec.ts"

# Run specific test files using vitest
npx vitest run packages/mermaid/src/diagrams/class/classDiagramGrammar.spec.ts packages/mermaid/src/diagrams/class/classParser.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
