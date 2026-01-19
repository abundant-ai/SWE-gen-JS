#!/bin/bash

cd /app/src

export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/fields-document/src/DocumentEditor/component-blocks"
cp "/tests/packages/fields-document/src/DocumentEditor/component-blocks/document-features-normalization.test.tsx" "packages/fields-document/src/DocumentEditor/component-blocks/document-features-normalization.test.tsx"
mkdir -p "packages/fields-document/src/DocumentEditor/component-blocks"
cp "/tests/packages/fields-document/src/DocumentEditor/component-blocks/insert-break-and-delete.test.tsx" "packages/fields-document/src/DocumentEditor/component-blocks/insert-break-and-delete.test.tsx"
mkdir -p "packages/fields-document/src/DocumentEditor/component-blocks"
cp "/tests/packages/fields-document/src/DocumentEditor/component-blocks/insertion-and-preview-props.test.tsx" "packages/fields-document/src/DocumentEditor/component-blocks/insertion-and-preview-props.test.tsx"
mkdir -p "packages/fields-document/src/DocumentEditor/component-blocks"
cp "/tests/packages/fields-document/src/DocumentEditor/component-blocks/normalization.test.tsx" "packages/fields-document/src/DocumentEditor/component-blocks/normalization.test.tsx"
mkdir -p "packages/fields-document/src/DocumentEditor"
cp "/tests/packages/fields-document/src/DocumentEditor/insert-menu.test.tsx" "packages/fields-document/src/DocumentEditor/insert-menu.test.tsx"
mkdir -p "packages/fields-document/src/DocumentEditor"
cp "/tests/packages/fields-document/src/DocumentEditor/markdown-link-shortcut.test.tsx" "packages/fields-document/src/DocumentEditor/markdown-link-shortcut.test.tsx"
mkdir -p "packages/fields-document/src/DocumentEditor/tests"
cp "/tests/packages/fields-document/src/DocumentEditor/tests/utils.tsx" "packages/fields-document/src/DocumentEditor/tests/utils.tsx"
mkdir -p "tests/sandbox"
cp "/tests/sandbox/component-blocks.tsx" "tests/sandbox/component-blocks.tsx"

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Run only the specific test files from this PR using Jest
# Using --runInBand to avoid memory issues with parallel test execution
yarn jest \
  packages/fields-document/src/DocumentEditor/component-blocks/document-features-normalization.test.tsx \
  packages/fields-document/src/DocumentEditor/component-blocks/insert-break-and-delete.test.tsx \
  packages/fields-document/src/DocumentEditor/component-blocks/insertion-and-preview-props.test.tsx \
  packages/fields-document/src/DocumentEditor/component-blocks/normalization.test.tsx \
  packages/fields-document/src/DocumentEditor/insert-menu.test.tsx \
  packages/fields-document/src/DocumentEditor/markdown-link-shortcut.test.tsx \
  --coverage=false \
  --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
