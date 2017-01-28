module.exports = (robot) ->
  robot.on 'channelJoin', (event) ->
    if event.channel.name == "introductions"
      robot.messageRoom "introductions", "Hi <@" + event.user.name + ">! Welcome to the Hackers and Builders Slack. Introduce yourself and tell us your major! I'll start by saying that I'm BMO, the resident chatbot.\nI support a number of commands, like `bmo garage` and `bmo animate edward snowden`.\n\nSome links you should check out, in no particular order:\nhttps://HackUCF.org\nhttps://TechKnights.org\nhttps://www.facebook.com/ACMatUCF/"

