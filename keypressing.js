// Generated by CoffeeScript 1.3.2
(function() {
  var microtime, pressed_keys, stdin;

  microtime = require('microtime');

  stdin = process.stdin;

  stdin.setRawMode(true);

  stdin.resume();

  stdin.setEncoding('utf8');

  pressed_keys = {};

  stdin.on('data', function(key) {
    console.log(microtime.now());
    if (!pressed_keys[key]) {
      pressed_keys[key] = {};
    }
    pressed_keys[key].last_press = microtime.now();
    setTimeout((function(key, last_press) {
      return function() {
        if (last_press === pressed_keys[key].last_press) {
          return console.log(key, ' is up');
        }
      };
    })(key, pressed_keys[key].last_press), 100);
    if (key === '\u0003') {
      return process.exit();
    }
  });

}).call(this);