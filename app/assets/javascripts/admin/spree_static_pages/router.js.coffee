# fuck the tests, just get the editor WIRED inthe morning.

window.SpreeStaticPages.Router.reopen
  rootURL: "/admin"

window.SpreeStaticPages.Router.map ()->
  @resource 'static_pages', { path: "/" }, ->
    @route "edit", path: "static_page/:static_page_id/edit"
    @route "new",  path: "static_page/new"

window.SpreeStaticPages.StaticPagesIndexRoute = Ember.Route.extend
  templateName: "static_page/index"
  renderTemplate: ->
    @render @templateName, controller: @controllerFor("static_pages.index")
  model: ->
    @store.find "static_page"

window.SpreeStaticPages.StaticPagesEditRoute = Ember.Route.extend
  templateName: "static_page/edit"
  renderTemplate: ->
    @render @templateName, controller: @controllerFor("static_pages.edit")
  model: (params) ->
    @store.find "static_page", params.static_page_id

window.SpreeStaticPages.StaticPagesNewRoute = Ember.Route.extend
  templateName: "static_page/edit"
  renderTemplate: ->
    @render @templateName, controller: @controllerFor("static_pages.new")
  model: () ->
    @store.createRecord "static_page"
