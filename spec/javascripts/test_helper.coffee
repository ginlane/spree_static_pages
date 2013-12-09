# Teaspoon includes some support files, but you can use anything from your own support path too.
#=require qunit
# require support/sinon
# require support/your-support-file
#
# Deferring execution
# If you're using CommonJS, RequireJS or some other asynchronous library you can defer execution. Call Teaspoon.execute()
# after everything has been loaded. Simple example of a timeout:
#
# Teaspoon.defer = true;
# setTimeout(Teaspoon.execute, 1000)
#
# Matching files
# By default Teaspoon will look for files that match _spec.{js,js.coffee,.coffee}. Add a filename_spec.js file in your
# spec path and it'll be included in the default suite automatically. If you want to customize suites, check out the
# configuration in config/initializers/teaspoon.rb
#
# Manifest
# If you'd rather require your spec files manually (to control order for instance) you can disable the suite matcher in
# the configuration and use this file as a manifest.
#
# For more information: http://github.com/modeset/teaspoon
#
# You can require javascript files here. A good place to start is by requiring your application.js.
#= require admin/spree_static_pages
#= require_self
#= require_tree ./fixtures
#= require_tree ./admin

window.App = SpreeStaticPages
#document.write "<div id='qunit'></div><div id='ember-testing'></div>"
App.reopen
  rootElement: "#ember-testing"
  simulateRemoteResponse: false

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
