#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_formatter/tests/specs/html/elements/inline"
cp "/tests/crates/biome_html_formatter/tests/specs/html/elements/inline/mixed-block-inline.html.snap" "crates/biome_html_formatter/tests/specs/html/elements/inline/mixed-block-inline.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/elements/inline"
cp "/tests/crates/biome_html_formatter/tests/specs/html/elements/inline/tags-hug-content-longer-w-attr.html.snap" "crates/biome_html_formatter/tests/specs/html/elements/inline/tags-hug-content-longer-w-attr.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/each_nested.svelte.snap" "crates/biome_html_formatter/tests/specs/html/svelte/each_nested.svelte.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/each_with_destructuring.svelte.snap" "crates/biome_html_formatter/tests/specs/html/svelte/each_with_destructuring.svelte.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte/whitespace"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/whitespace/issue-8584-w-newline.svelte" "crates/biome_html_formatter/tests/specs/html/svelte/whitespace/issue-8584-w-newline.svelte"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte/whitespace"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/whitespace/issue-8584-w-newline.svelte.snap" "crates/biome_html_formatter/tests/specs/html/svelte/whitespace/issue-8584-w-newline.svelte.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte/whitespace"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/whitespace/issue-8584.svelte" "crates/biome_html_formatter/tests/specs/html/svelte/whitespace/issue-8584.svelte"
mkdir -p "crates/biome_html_formatter/tests/specs/html/svelte/whitespace"
cp "/tests/crates/biome_html_formatter/tests/specs/html/svelte/whitespace/issue-8584.svelte.snap" "crates/biome_html_formatter/tests/specs/html/svelte/whitespace/issue-8584.svelte.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/whitespace"
cp "/tests/crates/biome_html_formatter/tests/specs/html/whitespace/preserve-newline-after-element.html" "crates/biome_html_formatter/tests/specs/html/whitespace/preserve-newline-after-element.html"
mkdir -p "crates/biome_html_formatter/tests/specs/html/whitespace"
cp "/tests/crates/biome_html_formatter/tests/specs/html/whitespace/preserve-newline-after-element.html.snap" "crates/biome_html_formatter/tests/specs/html/whitespace/preserve-newline-after-element.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/html/whitespace"
cp "/tests/crates/biome_html_formatter/tests/specs/html/whitespace/preserve-space-after-element.html" "crates/biome_html_formatter/tests/specs/html/whitespace/preserve-space-after-element.html"
mkdir -p "crates/biome_html_formatter/tests/specs/html/whitespace"
cp "/tests/crates/biome_html_formatter/tests/specs/html/whitespace/preserve-space-after-element.html.snap" "crates/biome_html_formatter/tests/specs/html/whitespace/preserve-space-after-element.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/prettier/html/aurelia"
cp "/tests/crates/biome_html_formatter/tests/specs/prettier/html/aurelia/basic.html.snap" "crates/biome_html_formatter/tests/specs/prettier/html/aurelia/basic.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/prettier/html/case"
cp "/tests/crates/biome_html_formatter/tests/specs/prettier/html/case/case.html.snap" "crates/biome_html_formatter/tests/specs/prettier/html/case/case.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/prettier/html/doctype_declarations"
cp "/tests/crates/biome_html_formatter/tests/specs/prettier/html/doctype_declarations/xhtml1.1.html.snap" "crates/biome_html_formatter/tests/specs/prettier/html/doctype_declarations/xhtml1.1.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/prettier/html/svg"
cp "/tests/crates/biome_html_formatter/tests/specs/prettier/html/svg/svg.html.snap" "crates/biome_html_formatter/tests/specs/prettier/html/svg/svg.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/prettier/html/tags"
cp "/tests/crates/biome_html_formatter/tests/specs/prettier/html/tags/openging-at-end.html.snap" "crates/biome_html_formatter/tests/specs/prettier/html/tags/openging-at-end.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/prettier/html/tags"
cp "/tests/crates/biome_html_formatter/tests/specs/prettier/html/tags/seach.html.snap" "crates/biome_html_formatter/tests/specs/prettier/html/tags/seach.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/prettier/html/tags"
cp "/tests/crates/biome_html_formatter/tests/specs/prettier/html/tags/tags.html.snap" "crates/biome_html_formatter/tests/specs/prettier/html/tags/tags.html.snap"
mkdir -p "crates/biome_html_formatter/tests/specs/prettier/vue/html-vue"
cp "/tests/crates/biome_html_formatter/tests/specs/prettier/vue/html-vue/elastic-header.html.snap" "crates/biome_html_formatter/tests/specs/prettier/vue/html-vue/elastic-header.html.snap"

# Run the specific test for biome_html_formatter
cargo test -p biome_html_formatter -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
