var express = require('express');
var app = express();
app.get('/ping', function(req, res) {
    console.log("received");
    res.setHeader('Content-Type', 'text/plain');
    res.end("PONG from build #4");
});
app.listen(80);
