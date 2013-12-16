window.SpreeStaticPages.PageSaver = Ember.Mixin.create
  isNew: true
  actions:
    save: ->
      page = @get "model"

      succ = (savedPage) =>
        @transitionToRoute "static_pages.edit", savedPage

      fail = (errors) ->
        @trigger "server:failure", errors

      page.save().then succ, fail
