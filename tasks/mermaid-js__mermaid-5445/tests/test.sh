#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/gitGraph.spec.js" "cypress/integration/rendering/gitGraph.spec.js"
mkdir -p "packages/mermaid/src/diagrams/git"
cp "/tests/packages/mermaid/src/diagrams/git/gitGraphParser.spec.js" "packages/mermaid/src/diagrams/git/gitGraphParser.spec.js"
mkdir -p "packages/mermaid/src/diagrams/git"
cp "/tests/packages/mermaid/src/diagrams/git/gitGraphParserV2.spec.js" "packages/mermaid/src/diagrams/git/gitGraphParserV2.spec.js"

# Run the specific test files using Vitest
pnpm exec vitest run packages/mermaid/src/diagrams/git/gitGraphParser.spec.js packages/mermaid/src/diagrams/git/gitGraphParserV2.spec.js --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
