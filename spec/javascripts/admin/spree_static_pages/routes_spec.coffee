module "SpreeStaticPages.Routes"
#     setup: ->
#     App.reset()


test "rendering the index", ->
  visit("/").then ->
    equal(find(".page").length, 2)
