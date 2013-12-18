window.SpreeStaticPages.StaticPagesEditController = Ember.ObjectController.extend Ember.Evented, SpreeStaticPages.PageSaver,
  isNew: false
  init: ->
    @on "server:failure", @, @updateErrors
    @on "server:success", @, @updateErrors

  isApproved: (->
    @get("model.state").toLowerCase() == "approved"
  ).property "model.state"

  updateErrors: (errors) ->
    @set "errors", errors #  set or clear errrrs

  nameError: (->  @getError "name" ).property "errors"
  pathError: (-> @getError "path" ).property "errors"
  contentError: ( ->  @getError "content" ).property "errors"

  getError: (name) ->
    e = @get "errors"
    e[name] if e

  previewUrl: -> @get("model").get("previewUrl")

  approvalChange: (url, state) ->
    succ = (data) =>
      @set "model.state", state
      @trigger "server:success"
      @transitionToRoute "static_pages.edit"
    fail = (jhr) =>
      errors = JSON.parse jhr.responseText
      @trigger "server:failure", errors
      @transitionToRoute "static_pages.edit"

    promise = $.ajax
      type: "put"
      url: url
      data:
        id: @get("model").id

    promise.done(succ).fail fail

  actions:
    disapprove: ->
      @approvalChange @get("model").get("disapproveUrl"), "Draft"

    approve: ->
      @approvalChange @get("model").get("approveUrl"), "Approved"
