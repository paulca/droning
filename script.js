var arDrone = require('ar-drone');
var client  = arDrone.createClient();

client.takeoff();

client
  .after(5000, function() {
        this.clockwise(0.5);
          })
  .after(3000, function() {
    this.up(1);
   })
  .after(1000, function() {
    this.animate('flipAhead');
  })
  .after(3000, function() {
        this.stop();
        this.land();
 });
