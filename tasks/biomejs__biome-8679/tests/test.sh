#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_formatter/tests"
cp "/tests/crates/biome_html_formatter/tests/quick_test.rs" "crates/biome_html_formatter/tests/quick_test.rs"
mkdir -p "crates/biome_html_formatter/tests/specs/html/astro"
cp "/tests/crates/biome_html_formatter/tests/specs/html/astro/component.astro" "crates/biome_html_formatter/tests/specs/html/astro/component.astro"
mkdir -p "crates/biome_html_formatter/tests/specs/html/astro"
cp "/tests/crates/biome_html_formatter/tests/specs/html/astro/component.astro.snap" "crates/biome_html_formatter/tests/specs/html/astro/component.astro.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/component.svelte" "crates/biome_html_formatter/tests/specs/html/svelte/component.svelte"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/component.svelte.snap" "crates/biome_html_formatter/tests/specs/html/svelte/component.svelte.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/vue"
cp "/tests/crates/biome_html_formatter/tests/specs/html/vue/component.vue" "crates/biome_html_formatter/tests/specs/html/vue/component.vue"
mkdir -p "crates/biome_html_formatter/tests/specs/html/vue"
cp "/tests/crates/biome_html_formatter/tests/specs/html/vue/component.vue.snap" "crates/biome_html_formatter/tests/specs/html/vue/component.vue.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/astro/component.astro" "crates/biome_html_parser/tests/html_specs/ok/astro/component.astro"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/astro"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/astro/component.astro.snap" "crates/biome_html_parser/tests/html_specs/ok/astro/component.astro.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/component.svelte" "crates/biome_html_parser/tests/html_specs/ok/svelte/component.svelte"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/svelte"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/svelte/component.svelte.snap" "crates/biome_html_parser/tests/html_specs/ok/svelte/component.svelte.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/component.vue" "crates/biome_html_parser/tests/html_specs/ok/vue/component.vue"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/component.vue.snap" "crates/biome_html_parser/tests/html_specs/ok/vue/component.vue.snap"
mkdir -p "crates/biome_html_parser/tests"
cp "/tests/crates/biome_html_parser/tests/quick_test.rs" "crates/biome_html_parser/tests/quick_test.rs"

# Run the snapshot tests for the biome_html_formatter and biome_html_parser packages
# These tests verify formatting and parsing of Vue, Svelte, and Astro components
cargo test -p biome_html_formatter -- --nocapture && \
cargo test -p biome_html_parser -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
