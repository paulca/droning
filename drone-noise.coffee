fs = require('fs')
file = '/tmp/decibel.txt'


fs = require('fs')
state = 'land'
last_state = null
setInterval ->
  fs.readFile file, 'utf8', (err,data) ->
    tier = parseInt(data)
    switch tier
    if parseInt(data) < -5
      state = 'land'
    else
      state = 'up'
    if state != last_state
      console.log(state)
    last_state = state
, 30