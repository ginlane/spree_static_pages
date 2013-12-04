window.SpreeStaticPages.IndexController = Ember.ArrayController.extend
  model: ->
    @store.find "static_page"
