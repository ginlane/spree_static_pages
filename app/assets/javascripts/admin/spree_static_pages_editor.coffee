(exports ? this).StaticPageEditor = class StaticPageEditor

  constructor: (elemOrSelector) ->
    @editBox = $ elemOrSelector
    return unless @editBox.length

    urls           = $ "#urls"
    @pageTitle     = $ ".page-title"
    @updateUrl     = urls.data "update"
    @createUrl     = urls.data "create"
    @isNew         = typeof urls.data("is-new") != "undefined"
    @approveButton = $ "#approve_button"
    @approveButton.show() if @isApproveable()

    @approveButton.on "keydown", @approve

    @editBox.on "keydown", @markEdited
    @editBox.on "submit", @save
    @editBox.find("#preview_button").on "click", @preview

  save: (e, cb) =>
    e.preventDefault() if e
    method   = if @isNew then "post" else "put"
    url      = if @isNew then @createUrl else @updateUrl
    response = $.ajax
      type: method
      url: url
      data: @editBox.serialize()

    response.done (response) =>
      @markSaved()
      @isNew     = false
      @updateUrl = @updateUrl.replace "ID", response.id
      @allowApproval() if @isApproveable()
      cb() if cb

    response.fail (response) =>
      @showErrors response

  showErrors: (e) =>
    console.log "Errors"
    console.log e

  preview: (e) =>
    e.preventDefault() if e

    return if @isNew
    @save false, =>
      if typeof @previewWindow != "undefined"
        @previewWindow.location.reload()
      else
        @previewWindow = window.open @updateUrl, "previewWindow"
        if e
          $(e.currentTarget).html "Refresh Preview"

  approve: (e) =>
    e.preventDefault()
    $("#approve").val(true)
    @save e

  allowApproval: =>
    $("#approve_button").show()

  disallowApproval: =>
    $("#approve_button").hide()

  isApproveable: =>
    !!$("#static_page_name").val() && !!$("#static_page_path").val() && !!$("#static_page_content")

  markSaved: =>
    text = @pageTitle.text()
    if /\*/.test(text)
      @pageTitle.text text.replace("*","")

  markEdited: =>
    text = @pageTitle.text()
    return if (/\*/.test(text))

    @pageTitle.text "#{text}*"
