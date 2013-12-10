window.SpreeStaticPages.StaticPagesNewController = Ember.ObjectController.extend
  templateName: "static_page/new"
  isNew: true
  actions:
    save: ->
      page = @get "model"
      succ = (savedPage) =>
        @transitionToRoute "static_pages.edit", savedPage
      fail = () ->
        alert "GAGAGASDFASDFASDFASDFASDF"

      page.save().then succ, fail
