# Description:
#   Logs all messages
fs = require 'fs'
module.exports = (robot) ->
  otr = {}

  logMessage = (msg) ->
    fs.appendFile "logs/" + msg.message.room + ".log", msg.message.user.name + ": " + msg.message.text + "\n", (error) ->
      if error
        console.log error

  robot.on 'reaction', (reaction) ->
    if reaction.message.reaction == 'bomb'
      emoji = ["bomb", "eyes", "joy", "pray", "birthday", "burrito", "taco", "hamburger", "metro", "mosque", "orange_book", "warning", "clock1", "clock2", "clock3", "clock4", "clock5", "clock6", "clock7","clock8","clock9","clock10","clock11","clock12"]
      for emo in emoji
        queryData =  {
            token: process.env.HUBOT_SLACK_TOKEN
            name: emo
            channel: reaction.message.item.channel # required with timestamp, uses rawMessage to find this
            timestamp: reaction.message.item.ts # this id is no longer undefined
          }

        if (queryData.timestamp?)
          robot.http("https://slack.com/api/reactions.add")
            .query(queryData)
            .post() (err, res, body) ->
              #TODO: error handling
              return

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
