#!/bin/bash

cd /app/src

# Environment variables already set in Dockerfile (CI=true)

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/quadrantChart.spec.js" "cypress/integration/rendering/quadrantChart.spec.js"
mkdir -p "packages/mermaid/src/diagrams/quadrant-chart/parser"
cp "/tests/packages/mermaid/src/diagrams/quadrant-chart/parser/quadrant.jison.spec.ts" "packages/mermaid/src/diagrams/quadrant-chart/parser/quadrant.jison.spec.ts"
mkdir -p "packages/mermaid/src/diagrams/quadrant-chart"
cp "/tests/packages/mermaid/src/diagrams/quadrant-chart/quadrantDb.spec.ts" "packages/mermaid/src/diagrams/quadrant-chart/quadrantDb.spec.ts"

# Run Vitest tests for the quadrant chart
# These are the core unit tests that validate the parser and database functionality
npx vitest run packages/mermaid/src/diagrams/quadrant-chart/parser/quadrant.jison.spec.ts packages/mermaid/src/diagrams/quadrant-chart/quadrantDb.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
