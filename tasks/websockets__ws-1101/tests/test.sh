#!/bin/bash

cd /app/src

# Test the flags removal - the fixed code should NOT pass flags parameter
# to message/ping/pong event handlers
node -e "
const WebSocket = require('./index');
const http = require('http');

// Create a minimal HTTP server for WebSocket
const server = http.createServer();
const wss = new WebSocket.Server({ server });

let testPassed = false;

wss.on('connection', function(ws) {
  // Send a message to the client
  ws.send('test message');
});

server.listen(0, function() {
  const port = server.address().port;
  // Create client connection
  const ws = new WebSocket('ws://localhost:' + port);

  ws.on('message', function(data, flags) {
    // In the FIXED version:
    // - flags parameter should NOT be passed (should be undefined)
    // - data should be the message string

    console.log('Message event received');
    console.log('data:', data);
    console.log('flags parameter exists:', flags !== undefined);
    console.log('typeof flags:', typeof flags);

    if (flags === undefined && data === 'test message') {
      console.log('PASS: flags parameter removed, only data parameter passed');
      testPassed = true;
    } else {
      console.log('FAIL: flags parameter still exists or data is wrong');
    }

    ws.close();
    server.close();
  });

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
