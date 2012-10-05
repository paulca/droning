arDrone = require 'ar-drone'
client  = arDrone.createClient()
# client.on('navdata', console.log);

class Drone
  state: 'stopped'

  takeoff: ->
    client.takeoff()

  stop: ->
    client.stop()
    @state = 'stopped'

  up: ->
    if @state != 'rising'
      client.up(0.1)
      @state = 'rising'

drone = new Drone()

stdin = process.stdin
stdin.setRawMode(true)
stdin.resume()
stdin.setEncoding 'utf8'
drone.last_press = null
last_key = null
stopped = true

stdin.on 'data', (key) ->
  console.log 'pressed ' + key + '\n'
  console.log 'last key was ' + last_key + '\n'
  stopped = false
  switch key
    when 't'
      if last_key != 't' || stopped == true
        console.log('Taking off')
        client.takeoff()
    when 'g'
      if last_key != 'g' || stopped == true
        console.log('Landing')
        client.land()
    when 'j'
      if last_key != 'j' || stopped == true
        console.log('rotating counter clockwise')
        client.counterClockwise(0.1) 
    when 'l'
      if last_key != 'l'
        console.log('rotating clockwise')
        client.clockwise(0.1) 
    when 'i'
      console.log('going up')
      client.up(0.1)
    when 'k'
      if last_key != 'k'
        console.log('rotating clockwise')
        client.down(0.1)
    when 'a'
      if last_key != 'a'
        console.log('turning left')
        client.left(0.1)
    when 'd'
      if last_key != 'd'
        console.log('turning right')
        client.right(0.1)
    when 'w'
      if last_key != 'w'
        console.log('going forward')
        client.front(0.1)
    when 's'
      if last_key != 's'
        console.log('going back')
        client.back(0.1)
    when 'x'
      console.log('Stopping')
      client.stop()
    when '\u0003'
      process.exit()
  last_key = key
  drone.this_press = new Date().getTime()
  setTimeout(((now, command)->
    ->
      if now == drone.last_press
        console.log('stopping')
        client.stop()
  )(drone.this_press), 50)
  drone.last_press = drone.this_press
