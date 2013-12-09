# For more information see: http://emberjs.com/guides/routing/

window.SpreeStaticPages.Router.reopen
  rootURL: "/admin"

window.SpreeStaticPages.Router.map ()->
  @resource 'static_page', { path: "/" }, ->
    @route "edit", path: "/edit/:static_page_id"

# window.SpreeStaticPages.StaticPageRoute = Ember.Route.extend
#   model: ->
#     @store.find "static_page"

window.SpreeStaticPages.IndexRoute = Ember.Route.extend
  templateName: "admin/spree_static_pages/index"
  model: ->
    @store.find "static_page"

window.SpreeStaticPages.StaticPageEditRoute = Ember.Route.extend
  templateName: "admin/spree_static_pages/static_page/edit"
  renderTemplate: ->
    @render @templateName, controller: @controllerFor("static_page.edit")
  model: (params) ->
    @store.find "static_page", params.static_page_id
