window.App = window.SpreeStaticPages

testing    = ->
  helper   =
    container: ->
      App.__container__
    controller: (name) ->
      helper.container().lookup "controller:#{name}"
    path: ->
      helper.controller('application').get 'currentPath'


Ember.Test.registerHelper 'path', ->
  testing().path()

Ember.Test.registerHelper 'controller', (name)->
  testing().controller(name)

Ember.Test.registerHelper 'testing', ->
  testing()

Ember.Test.registerHelper "running", ->
  Ember.Test.adapter.running



Ember.Test.adapter = Ember.Test.Adapter.create
  asyncStart: ->
    console.log "Async Start"
    @running = true

  asyncEnd: ->
    console.log "Async End"
    @running = false

  exception: (error) ->
    console.log error
    fail()


document.write "<div id='test-app-container'><div id='ember-testing'></div></div>"
App.reopen
  rootElement: "#ember-testing"

App.setupForTesting()
App.injectTestHelpers()
App.ApplicationAdapter = DS.FixtureAdapter.extend()
