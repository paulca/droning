var arDrone = require('ar-drone');                                              
var client  = arDrone.createClient();
// client.on('navdata', console.log);

var stdin = process.stdin;
// require('tty').setRawMode(true);
stdin.setRawMode(true);
stdin.resume();
stdin.setEncoding('utf8');
// var newData = null;

stdin.on('data', function (key) {
    // newData = new Date().getTime();
    process.stdout.write('pressed ' + key + '\n');
    if(key == 't')
    {
      process.stdout.write('Taking off');
      client.takeoff();
    }
    if(key == 'g')
      client.land();
    if(key == 'j')
      client.counterClockwise(0.5);
    if(key == 'k')
      client.clockwise(0.5);
    if(key == 'x')
      client.stop();
    if (key && key == '\u0003') process.exit();
});

// setInterval(function() {
//   if((new Date().getTime() - newData) > 10) {
//     client.stop();
//   }
// }, 10);
