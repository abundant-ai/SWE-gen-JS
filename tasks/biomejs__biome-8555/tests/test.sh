#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_parser/tests/html_specs/error/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/error/svelte/await_catch_before_then.svelte.snap" "crates/biome_html_parser/tests/html_specs/error/svelte/await_catch_before_then.svelte.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/error/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/error/svelte/await_invalid_catch_only_with_clause.svelte.snap" "crates/biome_html_parser/tests/html_specs/error/svelte/await_invalid_catch_only_with_clause.svelte.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/error/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/error/svelte/each_unclosed.svelte.snap" "crates/biome_html_parser/tests/html_specs/error/svelte/each_unclosed.svelte.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/error/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/error/svelte/invalid_curly_in_expression.svelte" "crates/biome_html_parser/tests/html_specs/error/svelte/invalid_curly_in_expression.svelte"
mkdir -p "crates/biome_html_parser/tests/html_specs/error/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/error/svelte/invalid_curly_in_expression.svelte.snap" "crates/biome_html_parser/tests/html_specs/error/svelte/invalid_curly_in_expression.svelte.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/await_catch_no_then.svelte" "crates/biome_html_parser/tests/html_specs/ok/svelte/await_catch_no_then.svelte"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/await_catch_no_then.svelte.snap" "crates/biome_html_parser/tests/html_specs/ok/svelte/await_catch_no_then.svelte.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/complex_expressions.svelte" "crates/biome_html_parser/tests/html_specs/ok/svelte/complex_expressions.svelte"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/complex_expressions.svelte.snap" "crates/biome_html_parser/tests/html_specs/ok/svelte/complex_expressions.svelte.snap"
mkdir -p "crates/biome_html_parser/tests"
cp "/tests/crates/biome_html_parser/tests/quick_test.rs" "crates/biome_html_parser/tests/quick_test.rs"

# Run the specific test for biome_html_parser
cargo test -p biome_html_parser -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
