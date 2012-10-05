// Generated by CoffeeScript 1.3.2
(function() {
  var Drone, arDrone, client, drone, microtime, pressed_keys, stdin;

  microtime = require('microtime');

  arDrone = require('ar-drone');

  client = arDrone.createClient();

  stdin = process.stdin;

  stdin.setRawMode(true);

  stdin.resume();

  stdin.setEncoding('utf8');

  pressed_keys = {};

  Drone = (function() {

    function Drone() {}

    Drone.prototype.states = {};

    Drone.prototype.mappings = {
      'i': 'up',
      'k': 'down',
      'j': 'counterClockwise',
      'l': 'clockwise',
      'a': 'left',
      'd': 'right',
      's': 'back',
      'f': 'flip',
      'w': 'front',
      'g': 'land',
      't': 'takeoff'
    };

    Drone.prototype.stop = function(key) {
      console.log('stopping');
      this.states[this.mappings[key]] = false;
      return client.stop();
    };

    Drone.prototype.process = function(action) {
      if (!this.states[action]) {
        console.log(action, this.states);
      }
      if (!this.states[action]) {
        return client[action](0.4);
      }
    };

    Drone.prototype.land = function() {
      return client.land();
    };

    Drone.prototype.takeoff = function() {
      console.log('taking off');
      return client.takeoff();
    };

    Drone.prototype.flip = function() {
      return client.animate('flipAhead');
    };

    Drone.prototype.keypress = function(key) {
      if (this.mappings[key]) {
        if (this[this.mappings[key]]) {
          this[this.mappings[key]]();
        } else {
          this.process(this.mappings[key]);
        }
        return this.states[this.mappings[key]] = true;
      }
    };

    return Drone;

  })();

  drone = new Drone();

  stdin.on('data', function(key) {
    drone.keypress(key);
    if (!pressed_keys[key]) {
      pressed_keys[key] = {};
    }
    pressed_keys[key].last_press = microtime.now();
    setTimeout((function(key, last_press) {
      return function() {
        if (last_press === pressed_keys[key].last_press) {
          console.log(key, ' is up');
          return drone.stop(key);
        }
      };
    })(key, pressed_keys[key].last_press), 100);
    if (key === '\u0003') {
      return process.exit();
    }
  });

}).call(this);
