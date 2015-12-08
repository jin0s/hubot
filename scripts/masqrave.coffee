module.exports = (robot) ->
  robot.respond /say ([A-Za-z0-9-]+) (.*)/i, (res) ->
    console.log res.match
    robot.messageRoom res.match[1], res.match[2]
