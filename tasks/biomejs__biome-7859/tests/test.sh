#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/invalid.options.json" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/invalid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/valid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/valid.options.json" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/allowForLoopAfterthought/valid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noIncrementDecrement/valid.js.snap"

# Rebuild the test binary after copying test files (tests are code-generated from spec files)
# Touch the test file to ensure cargo detects changes
touch crates/biome_js_analyze/tests/spec_tests.rs
cargo test -p biome_js_analyze --no-run 2>&1 | grep -v "^warning:" || true

# Run JS analyzer tests for the noIncrementDecrement rule
test_output=$(cargo test -p biome_js_analyze -- no_increment_decrement --nocapture 2>&1)
test_status=$?
echo "$test_output"

# Check if any tests actually ran (count total tests across all test suites)
total_tests=$(echo "$test_output" | grep "^running [0-9]* tests" | awk '{sum += $2} END {print sum}')
if [ "$total_tests" = "0" ] || [ -z "$total_tests" ]; then
  echo "ERROR: No tests ran for no_increment_decrement. Rule implementation missing." >&2
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
