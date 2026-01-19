#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_formatter/tests"
cp "/tests/crates/biome_html_formatter/tests/quick_test.rs" "crates/biome_html_formatter/tests/quick_test.rs"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/issue_8515.svelte" "crates/biome_html_formatter/tests/specs/html/svelte/issue_8515.svelte"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/issue_8515.svelte.snap" "crates/biome_html_formatter/tests/specs/html/svelte/issue_8515.svelte.snap"

# Run the specific test for biome_html_formatter
cargo test -p biome_html_formatter -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
