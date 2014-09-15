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
    room = (query && query.room) || process.env["HUBOT_MACKEREL_NOTIFIER_ROOM"]
    alert = data.alert
    host = data.host
    if alert && host
      role = host.roles[0]
      msg = "[Mackerel] #{alert.status.toUpperCase()}: #{alert.monitorName} at #{host.name} (#{host.status}) #{role.fullname} #{alert.url}"
      robot.messageRoom room, msg

    res.end ""

# {
#   "event": "alert",
#   "host": {
#     "id": "22D4...",
#     "name": "app01",
#     "url": "https://mackerel.io/orgs/.../hosts/...",
#     "type": "unknown",
#     "status": "working",
#     "memo": "",
#     "isRetired": false,
#     "roles": [
#       {
#         "fullname": "Service: role",
#         "serviceUrl": "https://mackerel.io/orgs/.../services/...",
#         "roleUrl": "https://mackerel.io/orgs/.../services/..."
#       }
#     ]
#   },
#   "alert": {
#     "url": "https://mackerel.io/orgs/.../alerts/2bj...",
#     "createdAt": 1409823378983,
#     "status": "critical",
#     "isOpen": true,
#     "trigger": "monitor",
#     "monitorName": "unreachable"
#   }
# }
