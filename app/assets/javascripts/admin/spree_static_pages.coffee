#= require admin/spree_backend
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require ./spree_static_pages/spree_static_pages

window.SpreeStaticPages = Ember.Application.create
  LOG_TRANSITIONS: true
  LOG_VIEW_LOOKUPS: true
  rootElement: "#static-pages-index"

#window.SpreeStaticPages.ApplicationSerializer = DS.ActiveModelSerializer.extend
