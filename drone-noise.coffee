fs = require('fs')
file = '/tmp/decibel.txt'


fs = require('fs')
setInterval ->
  fs.readFile file, 'utf8', (err,data) ->
    if data
      console.log('file', err, data)
, 30