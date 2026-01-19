#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/config/prettier-plugins/prettier-plugin-dummy-toml"
cp "/tests/config/prettier-plugins/prettier-plugin-dummy-toml/index.js" "tests/config/prettier-plugins/prettier-plugin-dummy-toml/index.js"
mkdir -p "tests/config/prettier-plugins/prettier-plugin-dummy-toml"
cp "/tests/config/prettier-plugins/prettier-plugin-dummy-toml/package.json" "tests/config/prettier-plugins/prettier-plugin-dummy-toml/package.json"
mkdir -p "tests/format/css/front-matter/embedded-language-formatting/__snapshots__"
cp "/tests/format/css/front-matter/embedded-language-formatting/__snapshots__/format.test.js.snap" "tests/format/css/front-matter/embedded-language-formatting/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/css/front-matter/embedded-language-formatting"
cp "/tests/format/css/front-matter/embedded-language-formatting/format.test.js" "tests/format/css/front-matter/embedded-language-formatting/format.test.js"
mkdir -p "tests/format/css/front-matter/embedded-language-formatting"
cp "/tests/format/css/front-matter/embedded-language-formatting/yaml.css" "tests/format/css/front-matter/embedded-language-formatting/yaml.css"
mkdir -p "tests/format/misc/front-matter/with-plugins/__snapshots__"
cp "/tests/format/misc/front-matter/with-plugins/__snapshots__/format.test.js.snap" "tests/format/misc/front-matter/with-plugins/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/misc/front-matter/with-plugins"
cp "/tests/format/misc/front-matter/with-plugins/format.test.js" "tests/format/misc/front-matter/with-plugins/format.test.js"
mkdir -p "tests/format/vue/with-plugins"
cp "/tests/format/vue/with-plugins/format.test.js" "tests/format/vue/with-plugins/format.test.js"

# Run the specific tests for this PR
npx jest tests/format/css/front-matter/embedded-language-formatting tests/format/misc/front-matter/with-plugins tests/format/vue/with-plugins --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
