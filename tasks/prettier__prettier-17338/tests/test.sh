#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/html/css/__snapshots__"
cp "/tests/format/html/css/__snapshots__/format.test.js.snap" "tests/format/html/css/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/html/css"
cp "/tests/format/html/css/mj-style.html" "tests/format/html/css/mj-style.html"
mkdir -p "tests/format/mjml/mj-style/__snapshots__"
cp "/tests/format/mjml/mj-style/__snapshots__/format.test.js.snap" "tests/format/mjml/mj-style/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/mjml/mj-style/embedded-language-formatting-off/__snapshots__"
cp "/tests/format/mjml/mj-style/embedded-language-formatting-off/__snapshots__/format.test.js.snap" "tests/format/mjml/mj-style/embedded-language-formatting-off/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/mjml/mj-style/embedded-language-formatting-off"
cp "/tests/format/mjml/mj-style/embedded-language-formatting-off/format.test.js" "tests/format/mjml/mj-style/embedded-language-formatting-off/format.test.js"
mkdir -p "tests/format/mjml/mj-style/embedded-language-formatting-off"
cp "/tests/format/mjml/mj-style/embedded-language-formatting-off/mj-style.mjml" "tests/format/mjml/mj-style/embedded-language-formatting-off/mj-style.mjml"
mkdir -p "tests/format/mjml/mj-style"
cp "/tests/format/mjml/mj-style/format.test.js" "tests/format/mjml/mj-style/format.test.js"
mkdir -p "tests/format/mjml/mj-style"
cp "/tests/format/mjml/mj-style/mj-style-complex.mjml" "tests/format/mjml/mj-style/mj-style-complex.mjml"
mkdir -p "tests/format/mjml/mj-style"
cp "/tests/format/mjml/mj-style/mj-style.mjml" "tests/format/mjml/mj-style/mj-style.mjml"
mkdir -p "tests/format/mjml/mj-style"
cp "/tests/format/mjml/mj-style/namespace.mjml" "tests/format/mjml/mj-style/namespace.mjml"
mkdir -p "tests/format/vue/style/__snapshots__"
cp "/tests/format/vue/style/__snapshots__/format.test.js.snap" "tests/format/vue/style/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/vue/style"
cp "/tests/format/vue/style/format.test.js" "tests/format/vue/style/format.test.js"
mkdir -p "tests/format/vue/style"
cp "/tests/format/vue/style/mj-style.vue" "tests/format/vue/style/mj-style.vue"

# Run the specific tests for this PR (multiple test directories)
npx jest tests/format/html/css tests/format/mjml/mj-style tests/format/vue/style --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
