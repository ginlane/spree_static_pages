window.SpreeStaticPages.StaticPageEditController = Ember.ObjectController.extend
  actions:
    save: ->
      page = @get "model"
      succ = (savedPage) =>
        @transitionToRoute "static_page.edit", savedPage
      fail = () ->
        alert "GAGAGASDFASDFASDFASDFASDF"

      page.save().then succ, fail
