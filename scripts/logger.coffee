# Description:
#   Logs all messages
fs = require 'fs'
module.exports = (robot) ->
  otr = {}


  logMessage = (msg) ->
    fs.appendFile "logs/" + msg.message.room + ".log", msg.message.user.name + ": " + msg.message.text + "\n", (error) ->
      if error
        console.log error

  robot.hear //i, (msg) ->
    if !otr[msg.message.room]
      logMessage(msg)
  robot.respond /otr/i, (res) ->
    otr[res.message.room] = true
    setTimeout ->
      if otr[res.message.room]
        res.send "Record back on."
        otr[res.message.room] = false
    , 5 * 60 * 1000
    res.send "My lips are sealed. Room going back on the record in 5 minutes."
  robot.respond /record/i, (res) ->
    otr[res.message.room] = false
    res.send "I'm all ears!"
