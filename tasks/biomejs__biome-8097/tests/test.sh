#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests"
cp "/tests/crates/biome_html_analyze/tests/spec_tests.rs" "crates/biome_html_analyze/tests/spec_tests.rs"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor/invalid.vue" "crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor/invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor/invalid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor/invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor/valid.vue" "crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor/valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor/valid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/noVueVIfWithVFor/valid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/ignore"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/ignore/valid-ignored.options.json" "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/ignore/valid-ignored.options.json"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/ignore"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/ignore/valid-ignored.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/ignore/valid-ignored.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/ignore"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/ignore/valid-ignored.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/ignore/valid-ignored.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/invalid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/invalid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/valid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/valid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueHyphenatedAttributes/valid.vue.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/v-bind-dynamic.vue.snap" "crates/biome_html_parser/tests/html_specs/ok/vue/v-bind-dynamic.vue.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/v-bind-mixed.vue.snap" "crates/biome_html_parser/tests/html_specs/ok/vue/v-bind-mixed.vue.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/v-dynamic-chains.vue.snap" "crates/biome_html_parser/tests/html_specs/ok/vue/v-dynamic-chains.vue.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/v-else-if.vue.snap" "crates/biome_html_parser/tests/html_specs/ok/vue/v-else-if.vue.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/v-html-text.vue.snap" "crates/biome_html_parser/tests/html_specs/ok/vue/v-html-text.vue.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/v-mixed-complex.vue.snap" "crates/biome_html_parser/tests/html_specs/ok/vue/v-mixed-complex.vue.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/v-model-mixed.vue.snap" "crates/biome_html_parser/tests/html_specs/ok/vue/v-model-mixed.vue.snap"
mkdir -p "crates/biome_html_parser/tests/html_specs/ok/vue"
cp "/tests/crates/biome_html_parser/tests/html_specs/ok/vue/v-on-mixed.vue.snap" "crates/biome_html_parser/tests/html_specs/ok/vue/v-on-mixed.vue.snap"
mkdir -p "crates/biome_html_parser/tests"
cp "/tests/crates/biome_html_parser/tests/quick_test.rs" "crates/biome_html_parser/tests/quick_test.rs"

# Run the Vue-related HTML analyze and parser tests
cargo test -p biome_html_analyze --test spec_tests -- --nocapture
html_analyze_status=$?

cargo test -p biome_html_parser --test quick_test -- --nocapture
html_parser_status=$?

# Both test suites must pass
if [ $html_analyze_status -eq 0 ] && [ $html_parser_status -eq 0 ]; then
  test_status=0
else
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
