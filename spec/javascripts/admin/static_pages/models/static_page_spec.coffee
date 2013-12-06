
describe "StaticPage Index", ->
  beforeEach ->
    App.StaticPage.FIXTURES = [
      { id: 1, path: "/path1", name: "Page 1", content: "I'm OLD FUCKING GREGG" }
      { id: 2, path: "/path2", name: "Page 2", content: "I'm Simon Mooooon!" }
    ]
    App.reset()

  it "should populate page table", ->
    Ember.run ->
      visit "/static_pages/edit/1"

    waitsFor ->
      !running()
