#!/bin/bash

cd /app/src

# Test the upgradeReq removal - the fixed code should NOT have ws.upgradeReq
# and should instead pass req as second parameter to connection event
node -e "
const WebSocket = require('./index');
const http = require('http');

// Create a minimal HTTP server for WebSocket
const server = http.createServer();
const wss = new WebSocket.Server({ server });

let testPassed = false;

wss.on('connection', function(ws, req) {
  // In the FIXED version:
  // - ws.upgradeReq should NOT exist
  // - req should be the http.IncomingMessage object

  console.log('Connection event received');
  console.log('ws.upgradeReq exists:', ws.upgradeReq !== undefined);
  console.log('req parameter exists:', req !== undefined);
  console.log('req is IncomingMessage:', req && req.constructor.name === 'IncomingMessage');

  if (ws.upgradeReq === undefined && req && req.constructor.name === 'IncomingMessage') {
    console.log('PASS: upgradeReq removed, req passed as second parameter');
    testPassed = true;
  } else {
    console.log('FAIL: upgradeReq still exists or req parameter missing');
  }

  ws.close();
  server.close();
});

server.listen(0, function() {
  const port = server.address().port;
  // Create client connection
  const ws = new WebSocket('ws://localhost:' + port);

  ws.on('error', function(err) {
    console.error('Client error:', err.message);
    process.exit(1);
  });
});

// Timeout after 5 seconds
setTimeout(function() {
  if (!testPassed) {
    console.error('Test timeout or failed');
    process.exit(1);
  }
  process.exit(0);
}, 5000);
"
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
