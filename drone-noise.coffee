fs = require('fs')
file = '/tmp/decibel.txt'


stdin = process.stdin
stdin.setRawMode(true)
stdin.resume()
stdin.setEncoding 'utf8'
pressed_keys = {}

arDrone = require('ar-drone');
client  = arDrone.createClient();
altitude = undefined;

client.config('general:navdata_demo', 'FALSE');

client.on 'navdata', (data) ->
  # console.log(data)
  if (data.demo)
    altitude = data.demo.altitudeMeters * 100;
    target = last_threshold
    if ((target - altitude) > -50 && (target - altitude) < 50)
      console.log altitude
      client.stop()

client.takeoff()

# goToAlt = (target) ->
#   console.log("Going to ", target)
#   getCloser = ->
#     if ((target - altitude) < -50)
#       console.log('down: at ', altitude)
#       client.down(0.5);
#       setTimeout(getCloser, 10);
#     if ((target - altitude) > 50)
#       console.log('up: at', altitude)
#       client.up(0.5);
#       setTimeout(getCloser, 10);
#     if ((target - altitude) > -50 && (target - altitude) < 50)
#       console.log('done')
#       client.stop();
#   getCloser()


state = 'land'
last_state = null
last_threshold = null
setInterval ->
  fs.readFile file, 'utf8', (err,data) ->
    tier = parseInt(data)
    if tier > -5
      state = 'up'
    else
      state = 'land'
    if tier < -5
      threshold = 500
    else if tier < -5
      threshold = 750
    else if tier < -4
      threshold = 1000
    else if tier < -3
      threshold = 1250
    else if tier < -2
      threshold = 1600
    else if tier < -1
      threshold = 1900
    else if tier < 0
      threshold = 2100
    else if tier < 1
      threshold = 2500
    else if tier < 2
      threshold = 2700
    else if tier < 3
      threshold = 3100
    else if tier < 4
      threshold = 3400
    else if tier < 6
      threshold = 4000
    else if tier >= 6
      threshold = 4500
      state = 'flip'

    if state != last_state
      console.log("State: #{state}")
    if threshold != last_threshold
      console.log("Threshold: #{threshold}", tier, altitude)
      if altitude < threshold
        console.log(altitude, threshold, 'go up')
        client.up(1)
      if altitude > threshold
        console.log(altitude, threshold, 'go down')
        client.down(1)
      if state == 'flip'
        client.animate('flipAhead', 15)

    last_state = state
    last_threshold = threshold
, 30

stdin.on 'data', (key) ->
  if key == '\u0003'
    process.exit()
  if key == 'g'
    client.land()