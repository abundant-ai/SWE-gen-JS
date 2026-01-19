#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-disabled"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-disabled/utility.css.snap" "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-disabled/utility.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/value-arbitrary.css.snap" "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/value-arbitrary.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/value-incomplete.css.snap" "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/value-incomplete.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/simple.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/simple.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/arbitrary-star.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/arbitrary-star.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/enhanced-value-function.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/enhanced-value-function.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/modifier.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/modifier.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/simple-utility.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/simple-utility.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/value-literals.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/value-literals.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/with-param.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/with-param.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/with-sub-block.css" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/with-sub-block.css"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/with-sub-block.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/utility/with-sub-block.css.snap"
mkdir -p "crates/biome_css_parser/tests"
cp "/tests/crates/biome_css_parser/tests/quick_test.rs" "crates/biome_css_parser/tests/quick_test.rs"
mkdir -p "crates/biome_css_parser/tests"
cp "/tests/crates/biome_css_parser/tests/spec_test.rs" "crates/biome_css_parser/tests/spec_test.rs"

# Run specific tests for this PR
# The PR modifies the quick_test function in quick_test.rs to test the new Tailwind CSS syntax
# We run quick_test with --ignored flag since it's marked with #[ignore]
cargo test -p biome_css_parser quick_test -- --ignored --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
