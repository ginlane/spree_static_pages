module "SpreeStaticPages.Routes"
#     setup: ->
#     App.reset()


test "rendering the index", ->
  Ember.run ->
    visit("/").then ->
      equal(find(".page").length, 2)