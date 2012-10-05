microtime = require 'microtime'
stdin = process.stdin
stdin.setRawMode(true)
stdin.resume()
stdin.setEncoding 'utf8'
pressed_keys = {}



stdin.on 'data', (key) ->
  console.log(microtime.now())
  if !pressed_keys[key]
    pressed_keys[key] = {}
  pressed_keys[key].last_press = microtime.now()
  setTimeout ((key, last_press) ->
    ->
      if last_press == pressed_keys[key].last_press
        console.log(key, ' is up')
  )(key, pressed_keys[key].last_press), 100

  if key == '\u0003'
    process.exit()