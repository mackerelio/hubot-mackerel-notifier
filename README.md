# hubot-mackerel

mackerel.io alert notification from webhook

## Configuration

* `HUBOT_MACKEREL_API_KEY`
  * API Key of Mackerel
* `HUBOT_MACKEREL_HOST_REGEXP`
  * Regular expression for identifing host FQDN, like "\\b[a-zA-Z0-9._-]+[.]example[.]com\\b"
* `HUBOT_MACKEREL_ORG_NAME`
  * Organization name
* `HUBOT_MACKEREL_NOTIFIER_ROOM`
  * target room to send notifications

```
export HUBOT_MACKEREL_API_KEY="..."
export HUBOT_MACKEREL_HOST_REGEXP="\\b[a-zA-Z0-9._-]+[.]example[.]com\\b"
export HUBOT_MACKEREL_ORG_NAME="exmaple"
export HUBOT_MACKEREL_NOTIFIER_ROOM="#general"
```