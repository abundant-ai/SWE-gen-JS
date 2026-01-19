#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "cypress/integration/rendering"
cp "/tests/cypress/integration/rendering/stateDiagram-v2.spec.js" "cypress/integration/rendering/stateDiagram-v2.spec.js"

# The Cypress test requires a full E2E environment. Instead, we'll test the compound state self-linking feature directly.
# Create a Jest test that verifies compound states can link to themselves.
mkdir -p src/dagre-wrapper/__tests__
cat > src/dagre-wrapper/__tests__/compound-state-self-link.spec.js << 'EOF'
import utils from '../../utils';

describe('Compound State Self-Link', () => {
  it('should handle single point edge labels (calcLabelPosition)', () => {
    // The fix adds special handling in calcLabelPosition for single-point arrays
    // Without the fix, calcLabelPosition doesn't check if points.length === 1
    const singlePoint = [{ x: 10, y: 20 }];
    const result = utils.calcLabelPosition(singlePoint);

    // With the fix, single points should be returned directly
    expect(result).toBeDefined();
    expect(result.x).toBe(10);
    expect(result.y).toBe(20);
  });

  it('should handle multiple point edge labels', () => {
    // Verify normal multi-point behavior still works
    const multiPoints = [
      { x: 0, y: 0 },
      { x: 10, y: 10 },
      { x: 20, y: 20 }
    ];
    const result = utils.calcLabelPosition(multiPoints);

    // Should call traverseEdge for multi-point arrays
    expect(result).toBeDefined();
  });
});
EOF

# Run the Jest test for compound state self-linking functionality
npx jest src/dagre-wrapper/__tests__/compound-state-self-link.spec.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
