var arDrone = require('ar-drone');
var client  = arDrone.createClient();
var altitude = undefined;

client.config('general:navdata_demo', 'FALSE');

client.on('navdata', function(data) {
  if (data.rawMeasures) {
    altitude = data.rawMeasures.altTempRaw;
  }
});

client.takeoff();

function goToAlt(target) {
  var getCloser = function() {
    if ((target - altitude) < 50) {
      client.down(0.5);
      setTimeout(getCloser, 1);
    }
    if ((target - altitude) > 50) {
      client.up(0.5);
      setTimeout(getCloser, 1);
    }
  }
  getCloser()
}
