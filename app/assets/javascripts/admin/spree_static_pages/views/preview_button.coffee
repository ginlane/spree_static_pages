window.SpreeStaticPages.PreviewButton = Ember.View.extend Ember.TargetActionSupport,
  tagName: "button"
  template: Ember.Handlebars.compile("Preview")
  showPreview: ->
    if typeof @previewWindow != "undefined" && @previewWindow.location
      @previewWindow.location.reload()
    else
      previewUrl = @get("controller").previewUrl()
      @previewWindow = window.open previewUrl, "previewWindow"

  click: (event) ->
    controller = @get "controller"
    if @controllerIsDirty()
      controller.on "server:success", =>
        controller.off "server:success", @
        @showPreview()
      @triggerAction action: "save", target: @get("controller")
    else
      @showPreview()

  controllerIsDirty: ->
    @get("controller").content.get('isDirty')