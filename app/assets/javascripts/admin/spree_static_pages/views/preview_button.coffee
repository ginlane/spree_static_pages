window.SpreeStaticPages.PreviewButton = Ember.View.extend
  tagName: "button"
  template: Ember.Handlebars.compile("Preview")
  click: (event) ->
    if typeof @previewWindow != "undefined" && @previewWindow.location
      @previewWindow.location.reload()
    else
      previewUrl = @get("controller").previewUrl()
      @previewWindow = window.open previewUrl, "previewWindow"
