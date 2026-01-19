#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_formatter/tests"
cp "/tests/crates/biome_html_formatter/tests/spec_test.rs" "crates/biome_html_formatter/tests/spec_test.rs"
mkdir -p "crates/biome_html_formatter/tests"
cp "/tests/crates/biome_html_formatter/tests/spec_tests.rs" "crates/biome_html_formatter/tests/spec_tests.rs"
mkdir -p "crates/biome_html_formatter/tests/specs/html/component-frameworks"
cp "/tests/crates/biome_html_formatter/tests/specs/html/component-frameworks/astro-component-casing.astro" "crates/biome_html_formatter/tests/specs/html/component-frameworks/astro-component-casing.astro"
mkdir -p "crates/biome_html_formatter/tests/specs/html/component-frameworks"
cp "/tests/crates/biome_html_formatter/tests/specs/html/component-frameworks/astro-component-casing.astro.snap" "crates/biome_html_formatter/tests/specs/html/component-frameworks/astro-component-casing.astro.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/component-frameworks"
cp "/tests/crates/biome_html_formatter/tests/specs/html/component-frameworks/html-canonical-lowercasing.html" "crates/biome_html_formatter/tests/specs/html/component-frameworks/html-canonical-lowercasing.html"
mkdir -p "crates/biome_html_formatter/tests/specs/html/component-frameworks"
cp "/tests/crates/biome_html_formatter/tests/specs/html/component-frameworks/html-canonical-lowercasing.html.snap" "crates/biome_html_formatter/tests/specs/html/component-frameworks/html-canonical-lowercasing.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/component-frameworks"
cp "/tests/crates/biome_html_formatter/tests/specs/html/component-frameworks/svelte-component-casing.svelte" "crates/biome_html_formatter/tests/specs/html/component-frameworks/svelte-component-casing.svelte"
mkdir -p "crates/biome_html_formatter/tests/specs/html/component-frameworks"
cp "/tests/crates/biome_html_formatter/tests/specs/html/component-frameworks/svelte-component-casing.svelte.snap" "crates/biome_html_formatter/tests/specs/html/component-frameworks/svelte-component-casing.svelte.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/component-frameworks"
cp "/tests/crates/biome_html_formatter/tests/specs/html/component-frameworks/vue-component-casing.vue" "crates/biome_html_formatter/tests/specs/html/component-frameworks/vue-component-casing.vue"
mkdir -p "crates/biome_html_formatter/tests/specs/html/component-frameworks"
cp "/tests/crates/biome_html_formatter/tests/specs/html/component-frameworks/vue-component-casing.vue.snap" "crates/biome_html_formatter/tests/specs/html/component-frameworks/vue-component-casing.vue.snap"

# Run the biome_html_formatter spec tests (which include the specs/html/component-frameworks test files)
cargo test -p biome_html_formatter --test spec_tests -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
