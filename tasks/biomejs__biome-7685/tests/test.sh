#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_analyze/tests"
cp "/tests/crates/biome_css_analyze/tests/spec_tests.rs" "crates/biome_css_analyze/tests/spec_tests.rs"
mkdir -p "crates/biome_css_analyze/tests/specs/correctness/noUnknownPseudoClass"
cp "/tests/crates/biome_css_analyze/tests/specs/correctness/noUnknownPseudoClass/validGlobal.css" "crates/biome_css_analyze/tests/specs/correctness/noUnknownPseudoClass/validGlobal.css"
mkdir -p "crates/biome_css_analyze/tests/specs/correctness/noUnknownPseudoClass"
cp "/tests/crates/biome_css_analyze/tests/specs/correctness/noUnknownPseudoClass/validGlobal.css.snap" "crates/biome_css_analyze/tests/specs/correctness/noUnknownPseudoClass/validGlobal.css.snap"

# Rebuild the test binary after copying test files
# Touch the test files to ensure cargo detects changes
touch crates/biome_css_analyze/tests/spec_tests.rs
cargo test -p biome_css_analyze --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the specific test file
test_output=""
test_status=0

# Run the spec_tests for the CSS analyzer
output=$(cargo test -p biome_css_analyze --test spec_tests -- --nocapture 2>&1)
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

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
