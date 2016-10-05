module.exports = (robot) ->
  robot.respond /hurricane/i, (res) ->
    robot.http("http://www.nhc.noaa.gov/refresh/graphics_at4+shtml/213032.shtml?5-daynl#contents").get() (err, _, body) ->
      s = body.split("<a href=\"?5-daynl#contents\">")
      s = s[1].split("<img src=\"")
      s = s[1].split("\"")
      res.send "http://www.nhc.noaa.gov/" + s[0]
