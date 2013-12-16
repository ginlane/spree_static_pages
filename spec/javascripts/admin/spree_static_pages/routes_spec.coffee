module "SpreeStaticPages.Routes", ->
  setup: ->
    Ember.run ->
      App.advanceReadiness()
      App.then -> done()
  teardown: ->
    App.reset()


test "rendering new", ->
  visit("/static_page/new").then ->
    equal(find(".static-page-form").length, 1, "Expected static page form")

test "rendering edit", ->
  visit("/static_page/1/edit").then ->
    equal(find(".static-page-form").length, 1, "Expected static page form")

test "rendering index", ->
  visit("/").then ->
    equal(find(".page").length, 2, "Two rows in page table")
