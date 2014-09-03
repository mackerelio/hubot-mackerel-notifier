# Description:
#   mackerel.io alert notification from webhook
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_MACKEREL_API_KEY
#   HUBOT_MACKEREL_HOST_REGEXP
#   HUBOT_MACKEREL_ORG_NAME
#   HUBOT_MACKEREL_NOTIFIER_ROOM
#
# Commands:
#   hostname.domain - looks up the mackerel.io host permalink
#   192.168.0.0 - looks up the mackerel.io host permalink (not implemented)
#
# Author:
#   mechairoi, stanaka

url           = require('url')
querystring   = require('querystring')

module.exports = (robot) ->
  robot.hear new RegExp(process.env.HUBOT_MACKEREL_HOST_REGEXP, "ig"), (msg) ->
    msg
      .http("https://mackerel.io/api/v0/hosts.json")
      .header('X-API-KEY', process.env.HUBOT_MACKEREL_API_KEY)
      .query
        name: msg.match
      .get() (err, res, body) ->
        parsedBody = JSON.parse body
        if parsedBody.status_code is not 200
          msg.send "Lookup failed #{response.status_txt}"
          return

        msg.send "https://mackerel.io/orgs/#{process.env.HUBOT_MACKEREL_ORG_NAME}/hosts/#{h.id}" for h in parsedBody.hosts

  robot.router.post "/hubot/mackerel", (req, res) ->
    query = querystring.parse(url.parse(req.url).query)
    data = req.body
    console.log(data)
    room = query.room || process.env["HUBOT_MACKEREL_NOTIFIER_ROOM"]
    state = if data.isOpen then "Open" else "Closed"
    alert = data.alerts[0]
    robot.messageRoom room, "[Mackerel] Alert #{state}: #{alert.reason} at #{data.host.name} (#{data.host.status})"
    robot.messageRoom "#nagios", "[Mackerel] Alert #{state}: #{alert.reason} at #{data.host.name} (#{data.host.status})"
    res.end ""

# {
#   "event":"alert",
#   "alert": {
#     "id":"28Y4h...",
#     "isOpen":false,
#     "createdAt":1405654501,
#     "url":"https://mackerel.io/orgs/.../alerts/...",
#     "hostId":"...",
#     "hostUrl":"https://mackerel.io/orgs/.../hosts/..."
#   },
#   "type":"mackerel"
# }
