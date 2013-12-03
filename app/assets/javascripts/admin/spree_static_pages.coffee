#= require admin/spree_backend
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require spree_static_pages/store
#= require spree_static_pages/spree_static_pages

window.SSP      = { }

window.SpreeStaticPagesEditor = Ember.Application.create
  rootElement: "#static-pages-editor"

window.SpreeStaticPagesIndex = Ember.Application.create
  rootElement: "#static-pages-index"
