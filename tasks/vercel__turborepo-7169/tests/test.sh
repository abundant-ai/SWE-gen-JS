#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/bad-turbo-json.t" "turborepo-tests/integration/tests/bad-turbo-json.t"
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/command-version.t" "turborepo-tests/integration/tests/command-version.t"
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/config.t" "turborepo-tests/integration/tests/config.t"
mkdir -p "turborepo-tests/integration/tests/daemon"
cp "/tests/turborepo-tests/integration/tests/daemon/verbosity.t" "turborepo-tests/integration/tests/daemon/verbosity.t"
mkdir -p "turborepo-tests/integration/tests/dry-json"
cp "/tests/turborepo-tests/integration/tests/dry-json/monorepo.t" "turborepo-tests/integration/tests/dry-json/monorepo.t"
mkdir -p "turborepo-tests/integration/tests/inference"
cp "/tests/turborepo-tests/integration/tests/inference/nested-workspaces.t" "turborepo-tests/integration/tests/inference/nested-workspaces.t"
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/no-args.t" "turborepo-tests/integration/tests/no-args.t"
mkdir -p "turborepo-tests/integration/tests/persistent-dependencies"
cp "/tests/turborepo-tests/integration/tests/persistent-dependencies/1-topological.t" "turborepo-tests/integration/tests/persistent-dependencies/1-topological.t"
mkdir -p "turborepo-tests/integration/tests/persistent-dependencies"
cp "/tests/turborepo-tests/integration/tests/persistent-dependencies/10-too-many.t" "turborepo-tests/integration/tests/persistent-dependencies/10-too-many.t"
mkdir -p "turborepo-tests/integration/tests/persistent-dependencies"
cp "/tests/turborepo-tests/integration/tests/persistent-dependencies/2-same-workspace.t" "turborepo-tests/integration/tests/persistent-dependencies/2-same-workspace.t"
mkdir -p "turborepo-tests/integration/tests/persistent-dependencies"
cp "/tests/turborepo-tests/integration/tests/persistent-dependencies/3-workspace-specific.t" "turborepo-tests/integration/tests/persistent-dependencies/3-workspace-specific.t"
mkdir -p "turborepo-tests/integration/tests/persistent-dependencies"
cp "/tests/turborepo-tests/integration/tests/persistent-dependencies/4-cross-workspace.t" "turborepo-tests/integration/tests/persistent-dependencies/4-cross-workspace.t"
mkdir -p "turborepo-tests/integration/tests/persistent-dependencies"
cp "/tests/turborepo-tests/integration/tests/persistent-dependencies/5-root-workspace.t" "turborepo-tests/integration/tests/persistent-dependencies/5-root-workspace.t"
mkdir -p "turborepo-tests/integration/tests/persistent-dependencies"
cp "/tests/turborepo-tests/integration/tests/persistent-dependencies/7-topological-nested.t" "turborepo-tests/integration/tests/persistent-dependencies/7-topological-nested.t"
mkdir -p "turborepo-tests/integration/tests/persistent-dependencies"
cp "/tests/turborepo-tests/integration/tests/persistent-dependencies/8-topological-with-extra.t" "turborepo-tests/integration/tests/persistent-dependencies/8-topological-with-extra.t"
mkdir -p "turborepo-tests/integration/tests/persistent-dependencies"
cp "/tests/turborepo-tests/integration/tests/persistent-dependencies/9-cross-workspace-nested.t" "turborepo-tests/integration/tests/persistent-dependencies/9-cross-workspace-nested.t"
mkdir -p "turborepo-tests/integration/tests/run"
cp "/tests/turborepo-tests/integration/tests/run/missing-tasks.t" "turborepo-tests/integration/tests/run/missing-tasks.t"
mkdir -p "turborepo-tests/integration/tests/task-dependencies"
cp "/tests/turborepo-tests/integration/tests/task-dependencies/workspace-tasks.t" "turborepo-tests/integration/tests/task-dependencies/workspace-tasks.t"
mkdir -p "turborepo-tests/integration/tests/workspace-configs"
cp "/tests/turborepo-tests/integration/tests/workspace-configs/persistent.t" "turborepo-tests/integration/tests/workspace-configs/persistent.t"

# Run the integration tests using prysk
# Navigate to integration test directory and run specific test files
cd turborepo-tests/integration
./node_modules/.bin/prysk \
  tests/bad-turbo-json.t \
  tests/command-version.t \
  tests/config.t \
  tests/daemon/verbosity.t \
  tests/dry-json/monorepo.t \
  tests/inference/nested-workspaces.t \
  tests/no-args.t \
  tests/persistent-dependencies/1-topological.t \
  tests/persistent-dependencies/10-too-many.t \
  tests/persistent-dependencies/2-same-workspace.t \
  tests/persistent-dependencies/3-workspace-specific.t \
  tests/persistent-dependencies/4-cross-workspace.t \
  tests/persistent-dependencies/5-root-workspace.t \
  tests/persistent-dependencies/7-topological-nested.t \
  tests/persistent-dependencies/8-topological-with-extra.t \
  tests/persistent-dependencies/9-cross-workspace-nested.t \
  tests/run/missing-tasks.t \
  tests/task-dependencies/workspace-tasks.t \
  tests/workspace-configs/persistent.t
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
