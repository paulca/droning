fs = require('fs')
file = '/tmp/decibel.txt'


fs = require('fs')
state = 'land'
last_state = null
setInterval ->
  fs.readFile file, 'utf8', (err,data) ->
    tier = parseInt(data)
    if tier > -5
      state = 'up'
    else
      state = 'land'
    if tier < -5
      threshold = 0  
    else if tier < -5
      threshold = 800
    else if tier < -4
      threshold = 1000
    else if tier < -3
      threshold = 1200
    else if tier < -2
      threshold = 1400
    else if tier < -1
      threshold = 1600
    else if tier < 0
      threshold = 1800
    else if tier < 1
      threshold = 2000
    else if tier < 2
      threshold = 2200
    else if tier < 3
      threshold = 2400
    else if tier < 4
      threshold = 2600
    else if tier < 5
      threshold = 2800
    else if tier > 6
      threshold = 3000
      state = 'flip'

    if state != last_state
      console.log("State: #{state}")
    if threshold != last_threshold
      console.log("Threshold: #{threshold}")

    last_state = state
    last_threshold = threshold
, 30