# For more information see: http://emberjs.com/guides/routing/

window.SpreeStaticPages.Router.reopen
  rootURL: "/admin"
  location: 'none'

window.SpreeStaticPages.Router.map ()->
  @resource 'static_page', { path: "static_pages" }

window.SpreeStaticPages.StaticPageRoute = Ember.Route.extend
  model: ->
    @store.find "static_page"

window.SpreeStaticPages.IndexRoute = Ember.Route.extend
  model: ->
    console.log "Route: index"
    @store.find "static_page"
