window.SpreeStaticPages.PageSaver = Ember.Mixin.create
  isNew: true
  actions:
    save: ->
      page = @get "model"

      succ = (savedPage) =>
        @trigger "server:success"
        @transitionToRoute "static_pages.edit", savedPage

      fail = (jhr) =>
        errors = JSON.parse jhr.responseText
        @trigger "server:failure", errors

      page.save().then succ, fail
