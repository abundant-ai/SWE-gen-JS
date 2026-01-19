#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_formatter/tests/specs/css/tailwind"
cp "/tests/crates/biome_css_formatter/tests/specs/css/tailwind/plugin-no-options.css" "crates/biome_css_formatter/tests/specs/css/tailwind/plugin-no-options.css"
mkdir -p "crates/biome_css_formatter/tests/specs/css/tailwind"
cp "/tests/crates/biome_css_formatter/tests/specs/css/tailwind/plugin-no-options.css.snap" "crates/biome_css_formatter/tests/specs/css/tailwind/plugin-no-options.css.snap"
mkdir -p "crates/biome_css_formatter/tests/specs/css/tailwind"
cp "/tests/crates/biome_css_formatter/tests/specs/css/tailwind/plugin-with-options.css" "crates/biome_css_formatter/tests/specs/css/tailwind/plugin-with-options.css"
mkdir -p "crates/biome_css_formatter/tests/specs/css/tailwind"
cp "/tests/crates/biome_css_formatter/tests/specs/css/tailwind/plugin-with-options.css.snap" "crates/biome_css_formatter/tests/specs/css/tailwind/plugin-with-options.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/plugin-with-invalid-options-2.css" "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/plugin-with-invalid-options-2.css"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/plugin-with-invalid-options-2.css.snap" "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/plugin-with-invalid-options-2.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/plugin-with-invalid-options.css" "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/plugin-with-invalid-options.css"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/plugin-with-invalid-options.css.snap" "crates/biome_css_parser/tests/css_test_suite/error/tailwind/when-enabled/plugin-with-invalid-options.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin-with-options-2.css" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin-with-options-2.css"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin-with-options-2.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin-with-options-2.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin-with-options.css" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin-with-options.css"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin-with-options.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin-with-options.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/plugin.css.snap"
mkdir -p "crates/biome_css_parser/tests/css_test_suite/ok/tailwind"
cp "/tests/crates/biome_css_parser/tests/css_test_suite/ok/tailwind/shadcn-default.css.snap" "crates/biome_css_parser/tests/css_test_suite/ok/tailwind/shadcn-default.css.snap"

# Run CSS formatter and parser tests for the tailwind-related test files
cargo test -p biome_css_formatter -p biome_css_parser -- tailwind --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
