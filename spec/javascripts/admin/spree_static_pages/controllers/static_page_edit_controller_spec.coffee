
module "SpreeStaticPages.StaticPagesEditController", ->
  setup: ->
    Ember.run ->

      getController("static_pages_edit").get("store").find "static_page"
      App.advanceReadiness()
      App.then -> done()

  teardown: ->
    App.reset()

test "isNew is false", ->
  controller = getController "static_pages_edit"
  ok !controller.isNew

test "controller should set isApproved true", ->
  expect 1
  visit("/static_page/1/edit").then ->
    ok find("#disapprove_button").hasClass("hidden"), "Disapprove button should be hidden"

test "controller should set isApproved false", ->
  expect 1
  visit("/static_page/2/edit").then ->
    ok find("#approve_button").hasClass("hidden"), "Approve button should be hidden"
