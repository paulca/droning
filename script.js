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

