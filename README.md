# hubot-mackerel-notifier [![No Maintenance Intended](https://unmaintained.tech/badge.svg)](https://unmaintained.tech/)

[NOTE] This library has been **deprecated**.

mackerel.io alert notification from webhook

## Screenshot

### Alert Notification
![](http://f.st-hatena.com/images/fotolife/m/mackerelio/20140915/20140915165010.png?1410767426)

### Hostname hearing
![](http://f.st-hatena.com/images/fotolife/m/mackerelio/20140915/20140915165009.png?1410767427)


## Getting Started

* Setup your hubot
* Add the script to your hubot.
```
npm install hubot-mackerel-notifier --save
```
* Add `hubot-mackerel-notifier` to `external-scripts.json`, like:
```
["hubot-mackerel-notifier"]
```
* Commit and Push
```
git commit -a -m 'add hubot-mackerel-notifier'
git push
```
* Add the [config variables](#configuration), like:
```
heroku config:add HUBOT_MACKEREL_API_KEY="..."
heroku config:add HUBOT_MACKEREL_HOST_REGEXP="\\b[a-zA-Z0-9._-]+[.]local-domain\\b"
heroku config:add HUBOT_MACKEREL_ORG_NAME="exmaple"
heroku config:add HUBOT_MACKEREL_NOTIFIER_ROOM="#general"
```
* Deploy your bot:
```
git push heroku master
```
* Enjoy!

## Configuration

This script uses following environment variables:

* `HUBOT_MACKEREL_API_KEY`
  * API Key of Mackerel
* `HUBOT_MACKEREL_HOST_REGEXP`
  * Regular expression for identifing host FQDN, like "\\b[a-zA-Z0-9._-]+[.]example[.]com\\b"
* `HUBOT_MACKEREL_ORG_NAME`
  * Organization name
* `HUBOT_MACKEREL_NOTIFIER_ROOM`
  * target room to send notifications

### Example

```
export HUBOT_MACKEREL_API_KEY="..."
export HUBOT_MACKEREL_HOST_REGEXP="\\b[a-zA-Z0-9._-]+[.]local-domain\\b"
export HUBOT_MACKEREL_ORG_NAME="exmaple"
export HUBOT_MACKEREL_NOTIFIER_ROOM="#general"
```

### Another example for heroku

```
heroku config:add HUBOT_MACKEREL_API_KEY="..."
heroku config:add HUBOT_MACKEREL_HOST_REGEXP="\\b[a-zA-Z0-9._-]+[.]local-domain\\b"
heroku config:add HUBOT_MACKEREL_ORG_NAME="exmaple"
heroku config:add HUBOT_MACKEREL_NOTIFIER_ROOM="#general"
```
