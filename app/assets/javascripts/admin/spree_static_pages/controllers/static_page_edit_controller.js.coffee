window.SpreeStaticPages.StaticPagesEditController = Ember.ObjectController.extend
  isNew: false
  previewUrl: -> @get("model").get("previewUrl")
  actions:
    save: ->
      page = @get "model"
      succ = (savedPage) =>
        @transitionToRoute "static_pages.edit", savedPage
      fail = () ->
        alert "GAGAGASDFASDFASDFASDFASDF"

      page.save().then succ, fail
