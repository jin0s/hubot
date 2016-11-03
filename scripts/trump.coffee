request = require 'request'
module.exports = (robot) ->
  lastData = {}
  getElection = (callback) ->
    request {method: 'GET', uri: "http://projects.fivethirtyeight.com/2016-election-forecast/florida/", gzip: true }, (err, _, body) ->
      s = body.split("data-party=\"D\" class=\"candidate-val winprob\">")
      s = s[1].split("<")

      clinton = s[0]

      s = body.split("data-party=\"R\" class=\"candidate-val winprob\">")
      s = s[1].split("<")

      trump = s[0]

      florida = body.split("Who will win Florida")[1]

      s = florida.split("data-party=\"D\" class=\"candidate-val winprob\">")
      s = s[1].split("<")

      clintonFlorida = s[0]

      s = florida.split("data-party=\"R\" class=\"candidate-val winprob\">")
      s = s[1].split("<")

      trumpFlorida = s[0]

      callback({ clinton: clinton, trump: trump, clintonFlorida: clintonFlorida, trumpFlorida: trumpFlorida })

  resString = (res) ->
    ':florida: FL: :clinton: ' + res.clintonFlorida + '% - :trump: ' + res.trumpFlorida + '% - :flag-us: National: :clinton: ' + res.clinton + '% - :trump: ' + res.trump + '%'

  robot.respond /election/i, (r) ->
    getElection (res) ->
      r.send resString(res)

  updateTopic = ->
    getElection (res) ->
      difference = false
      for key of res
        if lastData[key] != res[key]
          difference = true
          lastData[key] = res[key]

      return if not difference

      queryData =  {
        token: process.env.HUBOT_SLACK_TOKEN
        topic: resString(res)
        channel: "C2G9KELAW"
      }

      console.log 'Setting topic ' + queryData.topic

      robot.http("https://slack.com/api/channels.setTopic")
        .query(queryData)
        .post() (err, res, body) ->
          return

  updateTopic()
  setInterval updateTopic, 5 * 60 * 1000 + 3829 * 10

