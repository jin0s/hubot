copypasta = """
:ok_hand::eyes::ok_hand::eyes::ok_hand::eyes::ok_hand::eyes::ok_hand::eyes: good shit go౦ԁ sHit:ok_hand: thats :heavy_check_mark: some good:ok_hand::ok_hand:shit right:ok_hand::ok_hand:th :ok_hand: ere:ok_hand::ok_hand::ok_hand: right:heavy_check_mark:there :heavy_check_mark::heavy_check_mark:if i do ƽaү so my selｆ :100: i say so :100: thats what im talking about right there right there (chorus: ʳᶦᵍʰᵗ ᵗʰᵉʳᵉ) mMMMMᎷМ:100: :ok_hand::ok_hand: :ok_hand:НO0ОଠＯOOＯOОଠଠOoooᵒᵒᵒᵒᵒᵒᵒᵒᵒ:ok_hand: :ok_hand::ok_hand: :ok_hand: :100: :ok_hand: :eyes: :eyes: :eyes: :ok_hand::ok_hand:Good shit
"""

module.exports = (robot) ->
  robot.hear /.*(goo(o*)d( ?)shit).*/i, (res) ->
    # No restrictions
 
    # only up to 20 Goodshits per day
    today = new Date().toDateString()
    gsDay = robot.brain.get 'gsDay' or today
    gss = robot.brain.get 'gss' or 0
    unless gsDay == today and gss >= 20
      gss++
      res.send copypasta

    robot.brain.set 'gsDay', today
    robot.brain.set 'gss', gss
