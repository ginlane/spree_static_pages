#= require admin/spree_static_pages
#= require_self
#= require_tree ./fixtures
#= require_tree ./admin

window.App = SpreeStaticPages

App.reopen
  rootElement: "#ember-testing-app"

document.write "<div id='ember-testing-container'><div id='ember-testing-app'></div></div>"
document.write '<style>#ember-testing-container { position: absolute; background: white; bottom: 0; right: 0; width: 640px; height: 384px; overflow: auto; z-index: 9999; border: 1px solid #ccc; } #ember-testing-app { zoom: 50%; }</style>'


App.setupForTesting()
App.injectTestHelpers()


App.ApplicationAdapter = DS.FixtureAdapter.extend()
Ember.Test.adapter     = Ember.Test.QUnitAdapter.create()

QUnit.testStart ->
  Ember.run ->
    App.reset()
    Ember.testing = true

QUnit.testDone ->
  Ember.testing = false

QUnit.done ->
  Ember.run ->
    App.reset()
