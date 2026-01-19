#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.js" "crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.js"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.js.snap" "crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.options.json" "crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.js" "crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.js"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.js.snap" "crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.options.json" "crates/biome_js_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.options.json"
mkdir -p "crates/biome_json_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.json" "crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.json"
mkdir -p "crates/biome_json_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.json.snap" "crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.json.snap"
mkdir -p "crates/biome_json_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.options.json" "crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-lexicographic.options.json"
mkdir -p "crates/biome_json_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.json" "crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.json"
mkdir -p "crates/biome_json_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.json.snap" "crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.json.snap"
mkdir -p "crates/biome_json_analyze/tests/specs/source/useSortedKeys"
cp "/tests/crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.options.json" "crates/biome_json_analyze/tests/specs/source/useSortedKeys/group-by-nesting-natural.options.json"

# Rebuild the test binary after copying test files (tests are code-generated from spec files)
# Touch the test files to ensure cargo detects changes
touch crates/biome_js_analyze/tests/spec_tests.rs
touch crates/biome_json_analyze/tests/spec_tests.rs
cargo test -p biome_js_analyze --no-run 2>&1 | grep -v "^warning:" || true
cargo test -p biome_json_analyze --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the group-by-nesting test files in both JS and JSON analyzers
# The tests are auto-generated from the spec files, so we filter by the test name pattern
test_output=$(cargo test -p biome_js_analyze -p biome_json_analyze -- group_by_nesting --nocapture 2>&1)
test_status=$?
echo "$test_output"

# Check if any tests actually ran (count total tests across all test suites)
total_tests=$(echo "$test_output" | grep "^running [0-9]* tests" | awk '{sum += $2} END {print sum}')
if [ "$total_tests" = "0" ] || [ -z "$total_tests" ]; then
  echo "ERROR: No tests ran for group_by_nesting. Test files may be missing." >&2
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
