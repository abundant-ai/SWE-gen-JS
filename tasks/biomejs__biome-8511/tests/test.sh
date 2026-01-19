#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions/invalid.ts.snap" "crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions/invalid.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/codeOptionsUnsorted.jsx.snap" "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/codeOptionsUnsorted.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/issue_3394.jsx.snap" "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/issue_3394.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/issue_4855.jsx.snap" "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/issue_4855.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/issue_5601.jsx.snap" "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/issue_5601.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/quoteStyleInFunction.jsx.snap" "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/quoteStyleInFunction.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/sorted.jsx.snap" "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/sorted.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/templateLiteralSpace.jsx.snap" "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/templateLiteralSpace.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/unsorted.jsx.snap" "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/unsorted.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/whitespace.jsx.snap" "crates/biome_js_analyze/tests/specs/nursery/useSortedClasses/whitespace.jsx.snap"

# Run the specific tests for the nursery rules affected by this PR
# Note: We run all nursery tests since filtering to specific rules is complex in cargo test
# The affected rules are: noUnnecessaryConditions and useSortedClasses
cargo test -p biome_js_analyze --test spec_tests specs::nursery -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
