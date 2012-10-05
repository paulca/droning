var arDrone = require('ar-drone');                                              
var client  = arDrone.createClient();
client.on('navdata', console.log);

var stdin = process.openStdin(); 
require('tty').setRawMode(true);    

stdin.on('keypress', function (chunk, key) {
    process.stdout.write('Get Chunk: ' + chunk + '\n');
    process.stdout.write('pressed ' + key.name + '\n'); 
    if(key.name == 't')
    {
      process.stdout.write('Taking off');
      client.takeoff();
    }
    if(key.name == 'g')
      client.land();

    if (key && key.ctrl && key.name == 'c') process.exit();
});
