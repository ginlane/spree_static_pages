(exports ? this).StaticPageEditor = class StaticPageEditor

  constructor: (elemOrSelector) ->
    @editBox = $ elemOrSelector
    return unless @editBox.length
    @pageTitle = $ ".page-title"
    @editBox.on "submit", @save
    @editBox.find(".preview").on "click", @preview

  save: (e) =>
    e.preventDefault()
    response = $.post
      url: @editBox.attr("action")
      data: @editBox.serialize()

    response.done (response) =>
      @markSaved

    response.fail (response) =>
      @showErrors response

  showErrors: (e) =>

  preview: (e) =>

  updatePreview: (e) =>

  markSaved: =>
    text = @pageTitle.text()
    if(/\*/.test(text))
      @pageTitle.text text.replace("*","")

  markEdited: =>
    text = @pageTitle.text()
  	return if(/\*/.test(text))
    @pageTitle.text(text + "*")