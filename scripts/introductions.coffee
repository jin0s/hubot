module.exports = (robot) ->
  robot.on 'channelJoin', (event) ->
    if event.channel.name == "introductions"
      robot.messageRoom "introductions", "Hi <@" + event.user.name + ">! Welcome to the Hackers and Builders Slack. Feel free to introduce yourself! I'll start by saying that I'm BMO, an expert in robotics, data analaytics, and GIF selection. I'm also a bot."

