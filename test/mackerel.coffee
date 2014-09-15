path = require 'path'
fs = require 'fs'

# Hubot classes
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage

# Load assertion methods to this scope
chai = require 'chai'
#nock = require 'nock'
{ expect } = chai

describe 'hubot-mackerel-notifier', ->
  robot = null
  user = null
  adapter = null

  afterEach ->
    robot.server.close()
    robot.shutdown()

  beforeEach (done)->
    robot = new Robot null, 'mock-adapter', yes, 'Testbot'
    robot.adapter.on 'connected', ->
      robot.loadFile path.resolve('.'), 'index.coffee'
      hubotScripts = path.resolve 'node_modules', 'hubot', 'src', 'scripts'
      robot.loadFile hubotScripts, 'help.coffee'
      user = robot.brain.userForId '1', {
        name: 'mackerel'
        room: '#general'
      }
      adapter = robot.adapter
      waitForHelp = ->
        if robot.helpCommands().length > 0
          do done
        else
          setTimeout waitForHelp, 100
      do waitForHelp
    do robot.run

  describe 'help', ->
    it 'should have 4', (done)->
      expect(robot.helpCommands()).to.have.length 4
      do done

    it 'should parse help', (done)->
      adapter.on 'send', (envelope, strings)->
        try
          expect(strings[0]).to.equal """
          192.168.0.0 - looks up the mackerel.io host permalink (not implemented)
          hostname.domain - looks up the mackerel.io host permalink
          Testbot help - Displays all of the help commands that Testbot knows about.
          Testbot help <query> - Displays all help commands that match <query>.
          """
          do done
        catch e
          done e
      adapter.receive new TextMessage user, 'Testbot help'
