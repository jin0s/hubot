module.exports = (robot) ->
  THRESHOLD = 2 * 60 * 1000
  lastBoop = 0

  robot.hear /.*/g, (res) ->
    return if res.message.room != 'bmotestchannel'
    return if res.message.rawMessage.thread_ts

    return if (new Date).getTime() - lastBoop < THRESHOLD

    lastBoop = (new Date).getTime()

    queryData =  {
      token: process.env.HUBOT_SLACK_TOKEN
      channel: res.message.rawMessage.channel
      thread_ts: res.message.rawMessage.ts
      as_user: true
      text: "Great question! If you'd like, keep replies in this thread. If your question is resolved and you don't need/want more input, react to the parent message with :white_check_mark:."
    }

    robot.http("https://slack.com/api/chat.postMessage")
      .query(queryData)
      .post() (err, res, body) ->
        return
