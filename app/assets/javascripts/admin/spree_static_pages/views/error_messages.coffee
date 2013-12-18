window.SpreeStaticPages.ErrorMessage = Ember.View.extend
  tagName: "label"
  className: "isError:error"
  label: "FNORD"
  message: null

  isError: false
  template: Handlebars.compile("{{label}}<span>{{view.message}}</span>")
