wordlist = require 'word-list-json'
concatWotD = '(abatements|abernethies|abidances|aberrant|abiturs|abhorrer|abaser|abjoint|abnegation|abdomina)'
wotdRegex = /// \b#{concatWotD}\b ///ig
wotd = []
triggeredText = "*BMO HAS BEEN TRIGGERED BY _ #{matchedWord} _ YOU SHITLORD. CONSIDER THE FEELINGS OF THOSE OTHER THAN YOUR OWN. CIS SCUM.*"


module.exports = (robot) ->
  robot.hear wordRegex, (res) ->
    today = new Date().toDateString()
    triggerDay = robot.brain.get 'triggerDay' or today
    triggers = robot.brain.get 'triggers' or 0

    if concatWotD == '' or triggerDay != today
      generateDailyWords()

    matchedWord = res.matched[0];
    triggers++
    res.send triggeredText + "BMO has been triggered *#{triggers}* times."

    robot.brain.set 'triggerDay', today
    robot.brain.set 'triggers', triggers
    robot.brain.set 'wotd', wotd
    robot.brain.set 'concatWotD', concatWotD

  robot.respond /trigger warning/, (res) ->
    today = new Date().toDateString()
    triggerDay = robot.brain.get 'triggerDay' or today
    triggers = robot.brain.get 'triggers' or 0

    if concatWotD == '' or triggerDay != today
      generateDailyWords()

    res.send("*Attention everybody*, my trigger words are currently:\n" + wotd.join(', ') + '\n Thank you for understanding.');


  generateDailyWords = ->
    wotd = (wordlist[Math.floor(Math.random() * wordlist.length]) for [0...100])
    concatWotD = '(' + wotd.join('|') + ')'
