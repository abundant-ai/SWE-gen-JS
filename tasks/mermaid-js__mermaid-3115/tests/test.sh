#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/gitGraph.spec.js" "cypress/integration/rendering/gitGraph.spec.js"

# The Cypress test requires a full E2E environment. Instead, we'll test the parser directly.
# Create a Jest test that verifies cherry-pick functionality works.
mkdir -p src/diagrams/git/__tests__
cat > src/diagrams/git/__tests__/cherry-pick.spec.js << 'EOF'
import gitGraphAst from '../gitGraphAst';
import { parser } from '../parser/gitGraph';

describe('Git Graph cherry-pick', () => {
  beforeEach(() => {
    parser.yy = gitGraphAst;
    parser.yy.clear();
  });

  it('should parse cherry-pick command', () => {
    const str = `gitGraph:
      commit id: "ZERO"
      branch develop
      commit id:"A"
      checkout main
      commit id:"ONE"
      cherry-pick id:"A"
    `;

    expect(() => parser.parse(str)).not.toThrow();
    const commits = parser.yy.getCommits();

    // Should have ZERO, A, ONE, plus the cherry-picked commit
    expect(Object.keys(commits).length).toBeGreaterThanOrEqual(4);

    // Check that a cherry-pick commit type exists (type 4 = CHERRY_PICK)
    const commitValues = Object.values(commits);
    const cherryPickCommit = commitValues.find(c => c.type === 4);
    expect(cherryPickCommit).toBeDefined();
  });
});
EOF

# Run the Jest test for cherry-pick functionality
npx jest src/diagrams/git/__tests__/cherry-pick.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
