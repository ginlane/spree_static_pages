module "SpreeStaticPages.StaticPage"

test "has a name", ->
  prop = App.StaticPage.metaForProperty "name"
  equal prop.type, "string", "Expected #{prop.type} to == `string`"
