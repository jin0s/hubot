# Description:
#   Daily standups

module.exports = (robot) ->
  standup = ->
    robot.messageRoom 'general', "@channel Hello everyone! Time for standup. Please tell me:
    1) What you did yesterday
    2) What you plan to do today
    3) What, if anything, is standing in your way

    Have a great day everybody! :knighthacks: :night_with_stars: :computer:
    "
    robot.messageRoom 'sponsorship', "@channel Sponsorship standup! Any leads to follow up on? :knighthacks: :night_with_stars: :computer:"
    setTimeout(standup, 1000 * 60 * 60 * 24)
  if process.env.HUBOT_IS_BENDER?
    curTime = new Date()
    curTime.setHours(14)
    diff = (curTime.getTime() - new Date().getTime())
    if diff < 0
      diff = ((curTime.getTime() + 60 * 60 * 24 * 1000) - new Date().getTime())
    console.log("Scheduling standup for " + (diff / 1000 / 60 / 60) + " hours from now")
    setTimeout(standup, diff)

