# Description:
#   Daily standups

module.exports = (robot) ->
  standup = ->
    robot.messageRoom 'general', "<!channel> HACKATHON IS HAPPENING SOON! So stand up and get ready to be :lit: !
    \n1) What did you do yesterday?
    \n2) What do you plan to do today?
    \n3) What, if anything, is standing in your way?
    \n
    \nHave a great day team! And remember, every time you skip standup, God kills a :cat2:\n:knighthacks: :night_with_stars: :computer:
    "
    robot.messageRoom 'sponsorship', "<!channel> Sponsorship standup! Any leads to follow up on? :knighthacks: :night_with_stars: :computer:"
  ###
    setTimeout(standup, 1000 * 60 * 60 * 24)
  if process.env.HUBOT_IS_BENDER?
    curTime = new Date()
    curTime.setHours(11)
    diff = (curTime.getTime() - new Date().getTime())
    if diff < 0
      diff = ((curTime.getTime() + 60 * 60 * 24 * 1000) - new Date().getTime())
    console.log("Scheduling standup for " + (diff / 1000 / 60 / 60) + " hours from now")
    setTimeout(standup, diff)
  ###
