#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests"
cp "/tests/crates/biome_html_analyze/tests/spec_tests.rs" "crates/biome_html_analyze/tests/spec_tests.rs"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro/invalid.astro" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro/invalid.astro"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro/invalid.astro.snap" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro/invalid.astro.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro/valid.astro" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro/valid.astro"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro/valid.astro.snap" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/astro/valid.astro.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/invalid.html" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/invalid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte/invalid.svelte" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte/invalid.svelte"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte/invalid.svelte.snap" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte/invalid.svelte.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte/valid.svelte" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte/valid.svelte"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte/valid.svelte.snap" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/svelte/valid.svelte.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/valid.html" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/valid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/valid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue/invalid.vue" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue/invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue/invalid.vue.snap" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue/invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue/valid.vue" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue/valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue/valid.vue.snap" "crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/vue/valid.vue.snap"

# Run the specific tests for useIframeTitle
# The tests are in crates/biome_html_analyze/tests/specs/a11y/useIframeTitle/
cargo test -p biome_html_analyze use_iframe_title -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
