window.SpreeStaticPages.ErrorMessages = Ember.View.extend
  tagName: "div"
  className: "hidden"
  template: Handlebars.compile("<ul><ul>") # {{#each error in errors}}<li>{{error}}</li>{{/each}}
  didInsertElement: ->
    @get("controller").on("server:failure", $.proxy(@serverFailure, @))
  serverFailure: (errors) =>
