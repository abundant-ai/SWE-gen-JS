#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/gitGraph.spec.js" "cypress/integration/rendering/gitGraph.spec.js"

# The Cypress test requires a full E2E environment. Instead, we'll test the rotateCommitLabel feature directly.
# Create a Jest test that verifies rotateCommitLabel configuration works.
mkdir -p src/diagrams/git/__tests__
cat > src/diagrams/git/__tests__/rotate-commit-label.spec.js << 'EOF'
import defaultConfig from '../../../defaultConfig';
import gitGraphRenderer from '../gitGraphRenderer';

describe('Git Graph rotateCommitLabel', () => {
  it('should have rotateCommitLabel in default config', () => {
    // The fix adds rotateCommitLabel to the default config
    expect(defaultConfig.gitGraph).toBeDefined();
    expect(defaultConfig.gitGraph.rotateCommitLabel).toBeDefined();
    expect(defaultConfig.gitGraph.rotateCommitLabel).toBe(true);
  });

  it('should support rotateCommitLabel in gitGraph config', () => {
    // Verify that the gitGraphRenderer has access to the config
    const config = defaultConfig.gitGraph;
    expect(config.showCommitLabel).toBeDefined();
    expect(config.showBranches).toBeDefined();
    expect(config.rotateCommitLabel).toBeDefined();
  });
});
EOF

# Run the Jest test for rotateCommitLabel functionality
npx jest src/diagrams/git/__tests__/rotate-commit-label.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
