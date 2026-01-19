#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-disabled"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-disabled/custom-theme.css" "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-disabled/custom-theme.css"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-disabled"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-disabled/custom-theme.css.snap" "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-disabled/custom-theme.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/theme"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/theme/custom-theme.css" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/theme/custom-theme.css"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/theme"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/theme/custom-theme.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/theme/custom-theme.css.snap"

# Rebuild the test binary after copying test files (tests are code-generated from spec files)
# Touch the test file to ensure cargo detects changes
touch crates/biome_css_parser/tests/spec_tests.rs
cargo test -p biome_css_parser --no-run 2>&1 | grep -v "^warning:" || true

# Run CSS parser tests for the custom-theme test files
# The tests are auto-generated from the CSS files, so we filter by the test name pattern
test_output=$(cargo test -p biome_css_parser -- custom_theme --nocapture 2>&1)
test_status=$?
echo "$test_output"

# Check if any tests actually ran (count total tests across all test suites)
total_tests=$(echo "$test_output" | grep "^running [0-9]* tests" | awk '{sum += $2} END {print sum}')
if [ "$total_tests" = "0" ] || [ -z "$total_tests" ]; then
  echo "ERROR: No tests ran for custom_theme. Test files may be missing." >&2
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
