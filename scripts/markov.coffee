markov = require 'markov'
fs = require 'fs'

getMessagesFromUser = (user, cb) ->
  user = user.toLowerCase()
  fs.readdir("logs/", (err, list) ->
    messages = ""
    list.forEach (file) ->
      logs = fs.readFileSync("logs/" + file).toString()
      
      lines = logs.split("\n")
      for line in lines
        parts = line.split ':'
        from = parts[0]
        message = parts[1]
        if from.toLowerCase() == user
          messages += message + "\n"
    cb messages
  )
module.exports = (robot) ->
  robot.respond /markov \@?(.*)/i, (res) ->
    
    user = res.match[1]
    getMessagesFromUser user, (messages) ->
      m = markov()
      m.seed(messages, () ->
        res.send m.fill(m.pick(), Math.random() * 14 + 5).join(" ")
      )

