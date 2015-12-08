# Description:
#   Confirmations

module.exports = (robot) ->
  if process.env.HUBOT_IS_BENDER?
    robot.respond /confirmations/i, (res) ->
      mysql = require('mysql')
      connection = mysql.createConnection({
        host     : 'localhost',
        user     : process.env.HUBOT_MYSQL_USER,
        password : process.env.HUBOT_MYSQL_PASS,
        database : 'hack'
      })
      connection.connect()
      connection.query('SELECT COUNT(*) FROM confirmations WHERE has_confirmed = 1', (err, rows, fields) ->
        if err
          throw err
        confirmed = rows[0]['COUNT(*)']
        connection.query('SELECT COUNT(*) FROM confirmations', (err, rows, fields) ->
          total = rows[0]['COUNT(*)']
          res.send('Confirmations: ' + confirmed + '/' + total + ' (' + (confirmed / total * 100) + '%)')
          connection.query('select school, count(*) from confirmations where transportation = 1 and has_confirmed = 1 group by school order by count(*) desc', (err, rows, fields) ->
            console.log(err)
            console.log(rows)
            res.send('Students wanting transport: ')
            msg = '```'
            for row in rows
              msg += row['school'] + ': ' + row['count(*)'] + "\n"
            msg += '```'
            res.send(msg)
            connection.end()
          )
        )
      )
