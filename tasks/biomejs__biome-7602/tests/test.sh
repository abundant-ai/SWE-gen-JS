#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.invalid.js" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.invalid.options.json" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.invalid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.valid.js" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.valid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.valid.options.json" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/noRequireCatchParameter.valid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/valid.js" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useErrorCause"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useErrorCause/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useErrorCause/valid.js.snap"

# Rebuild the test binary after copying test files
# Touch the test files to ensure cargo detects changes
touch crates/biome_js_analyze/tests/specs/nursery/useErrorCause/invalid.js
cargo test -p biome_js_analyze --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the useErrorCause rule
test_output=""
test_status=0

# Run the specific test for useErrorCause rule
output=$(cargo test -p biome_js_analyze use_error_cause -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

echo "$test_output"

# Check if any tests actually ran
total_tests=$(echo "$test_output" | grep "^running [0-9]* tests" | awk '{sum += $2} END {print sum}')
if [ "$total_tests" = "0" ] || [ -z "$total_tests" ]; then
  echo "ERROR: No tests ran. Test files may be missing." >&2
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

test_status=$status

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
