#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules"
cp "/tests/crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules/valid_with_ignore.css" "crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules/valid_with_ignore.css"
mkdir -p "crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules"
cp "/tests/crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules/valid_with_ignore.css.snap" "crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules/valid_with_ignore.css.snap"
mkdir -p "crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules"
cp "/tests/crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules/valid_with_ignore.options.json" "crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules/valid_with_ignore.options.json"

# Rebuild the test binary after copying test files
# Touch the test files to ensure cargo detects changes
touch crates/biome_css_analyze/tests/specs/suspicious/noUnknownAtRules/valid_with_ignore.css
cargo test -p biome_css_analyze --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the noUnknownAtRules spec
# The test is generated from the spec files via tests_macros::gen_tests! macro
# Run all tests in the suspicious::no_unknown_at_rules module to capture our specific test
test_output=$(cargo test -p biome_css_analyze --test spec_tests suspicious::no_unknown_at_rules -- --nocapture 2>&1)
test_status=$?
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
