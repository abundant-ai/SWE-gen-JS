#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_parser/tests/html_specs/error/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/error/astro/nested_expression.astro" "crates/biome_html_parser/tests/html_specs/error/astro/nested_expression.astro"
mkdir -p "crates/biome_html_parser/tests/html_specs/error/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/error/astro/nested_expression.astro.snap" "crates/biome_html_parser/tests/html_specs/error/astro/nested_expression.astro.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/astro/issue_7837.astro" "crates/biome_html_parser/tests/html_specs/ok/astro/issue_7837.astro"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/astro/issue_7837.astro.snap" "crates/biome_html_parser/tests/html_specs/ok/astro/issue_7837.astro.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/astro/multiple_nested_expression.astro" "crates/biome_html_parser/tests/html_specs/ok/astro/multiple_nested_expression.astro"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/astro/multiple_nested_expression.astro.snap" "crates/biome_html_parser/tests/html_specs/ok/astro/multiple_nested_expression.astro.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/astro/nested_expression.astro" "crates/biome_html_parser/tests/html_specs/ok/astro/nested_expression.astro"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/astro/nested_expression.astro.snap" "crates/biome_html_parser/tests/html_specs/ok/astro/nested_expression.astro.snap"

# Run the biome_html_parser spec tests (which include the html_specs test files)
cargo test -p biome_html_parser --test spec_tests -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
