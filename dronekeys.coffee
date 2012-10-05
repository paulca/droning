microtime = require 'microtime'

arDrone = require 'ar-drone'
client  = arDrone.createClient()

stdin = process.stdin
stdin.setRawMode(true)
stdin.resume()
stdin.setEncoding 'utf8'
pressed_keys = {}

class Drone
  states: {}

  mappings: {
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
  }

  stop: (key)->
    console.log('stopping')
    @states[@mappings[key]] = false
    client.stop()

  process: (action)->
    console.log(action, @states) unless @states[action]
    client[action](0.4) unless @states[action]

  land: ->
    client.land()

  takeoff: ->
    console.log('taking off')
    client.takeoff()

  flip: ->
    client.animate('flipAhead')

  keypress: (key) ->
    if @mappings[key]
      if @[@mappings[key]]
        @[@mappings[key]]()
      else
        @process(@mappings[key])
      @states[@mappings[key]] = true

drone = new Drone()

stdin.on 'data', (key) ->
  drone.keypress(key)
  if !pressed_keys[key]
    pressed_keys[key] = {}
  pressed_keys[key].last_press = microtime.now()
  setTimeout ((key, last_press) ->
    ->
      if last_press == pressed_keys[key].last_press
        console.log(key, ' is up')
        drone.stop(key)
  )(key, pressed_keys[key].last_press), 100

  if key == '\u0003'
    process.exit()