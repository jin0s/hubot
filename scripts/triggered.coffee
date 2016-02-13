wordlist = require './word-list'
concatWotD = '(abatements|abernethies|abidances|aberrant|abiturs|abhorrer|abaser|abjoint|abnegation|abdomina)'
wotdRegex = /// \b#{concatWotD}\b ///ig
wotd = []

brain = {}

module.exports = (robot) ->
  robot.hear /(.*)/, (res) ->
    today = new Date().toDateString()
    triggerDay = brain['triggerDay']
    triggers = brain['triggers'] or 0

    if concatWotD == '' or triggerDay != today
      generateDailyWords()
      triggerDay = today

    match = wotdRegex.exec(res.message.text)
    return if not match
    matchedWord = match[0]
    triggeredText = "*BMO HAS BEEN TRIGGERED BY _ #{matchedWord} _ YOU SHITLORD. CONSIDER THE FEELINGS OF THOSE OTHER THAN YOUR OWN. CIS SCUM.*"
    triggers++
    res.send triggeredText + "BMO has been triggered *#{triggers}* times."

    brain['triggerDay'] = today
    brain['triggers'] = triggers
    brain['wotd'] = wotd
    brain['concatWotD'] = concatWotD

  robot.respond /trigger warning/, (res) ->
    today = new Date().toDateString()
    triggerDay = brain['triggerDay']
    triggers = brain['triggers'] or 0

    if concatWotD == '' or triggerDay != today
      brain['triggerDay'] = today
      generateDailyWords()

    res.send("*Attention everybody*, my trigger words are currently:\n" + wotd.join(', ') + '\n Thank you for understanding.');


  generateDailyWords = ->
    wotd = (wordlist[Math.floor(Math.random() * wordlist.length)] for [0...100])
    concatWotD = '(' + wotd.join('|') + ')'
    wotdRegex = /// \b#{concatWotD}\b ///ig
