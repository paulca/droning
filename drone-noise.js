// Generated by CoffeeScript 1.3.2
(function() {
  var file, fs;

  fs = require('fs');

  file = '/tmp/decibel.txt';

  fs = require('fs');

  setInterval(function() {
    return fs.readFile(file, 'utf8', function(err, data) {
      if (data) {
        return console.log('file', err, data);
      }
    });
  }, 30);

}).call(this);