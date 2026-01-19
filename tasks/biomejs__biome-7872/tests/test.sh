#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_parser/tests/html_specs/error"
cp "/tests/crates/biome_html_parser/tests/html_specs/error/interpolation-attributes.html" "crates/biome_html_parser/tests/html_specs/error/interpolation-attributes.html"
mkdir -p "crates/biome_html_parser/tests/html_specs/error"
cp "/tests/crates/biome_html_parser/tests/html_specs/error/interpolation-attributes.html.snap" "crates/biome_html_parser/tests/html_specs/error/interpolation-attributes.html.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/dynamic-prop.svelte" "crates/biome_html_parser/tests/html_specs/ok/svelte/dynamic-prop.svelte"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/dynamic-prop.svelte.snap" "crates/biome_html_parser/tests/html_specs/ok/svelte/dynamic-prop.svelte.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/shorthand-prop.svelte" "crates/biome_html_parser/tests/html_specs/ok/svelte/shorthand-prop.svelte"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/shorthand-prop.svelte.snap" "crates/biome_html_parser/tests/html_specs/ok/svelte/shorthand-prop.svelte.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/shorthand-spread-props.svelte" "crates/biome_html_parser/tests/html_specs/ok/svelte/shorthand-spread-props.svelte"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/shorthand-spread-props.svelte.snap" "crates/biome_html_parser/tests/html_specs/ok/svelte/shorthand-spread-props.svelte.snap"

# Run the biome_html_parser spec tests (which include the html_specs test files)
cargo test -p biome_html_parser --test spec_tests -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
