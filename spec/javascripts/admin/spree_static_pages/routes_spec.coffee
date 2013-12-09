module "SpreeStaticPages.Routes"
#   setup: ->
#     App.reset()


test "rendering the index", ->
  visit("/static_pages/edit/1").then ->
    equal(find(".page").length, 2)
