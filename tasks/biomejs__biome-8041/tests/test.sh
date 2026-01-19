#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants/dark.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants/dark.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants/shorthand-multiple-selectors.css" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants/shorthand-multiple-selectors.css"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants/shorthand-multiple-selectors.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants/shorthand-multiple-selectors.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants/shorthand.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/custom-variants/shorthand.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/shadcn-default.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/shadcn-default.css.snap"

# Run the biome_css_parser tests for tailwind custom variants and shadcn
# Using cargo test filter to target the specific CSS test suite tests
cargo test -p biome_css_parser --test spec_tests tailwind -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
