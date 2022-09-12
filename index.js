/*
var express = require('express');
var app = express();

app.get('/', function (req, res) {
    res.send('{ "response": "Hello From Berat" }');
});

app.listen(process.env.PORT || 3000);
module.exports = app;
*/

'use strict';

const express = require('express');

// Constants
const PORT = 3000;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  res.send('Hello World');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
