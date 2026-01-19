#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/at_rule"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/at_rule/at_rule_import.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/at_rule/at_rule_import.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/tw-import.css" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/tw-import.css"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/tw-import.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/tw-import.css.snap"

# Run the specific CSS parser tests affected by this PR
# The affected test files are at_rule_import.css and tw-import.css
# Note: tw-import files don't exist in buggy state (deleted by bug.patch)
# Running all ok tests in the CSS parser test suite
cargo test -p biome_css_parser --test spec_tests ok -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
