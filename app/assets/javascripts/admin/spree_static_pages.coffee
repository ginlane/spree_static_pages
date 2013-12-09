#= require jquery
#= require ./spree_static_pages/lib/handlebars
#= require ./spree_static_pages/lib/ember
#= require ./spree_static_pages/lib/ember-data
#= require handlebars.runtime
#= require_self
#= require ./spree_static_pages/spree_static_pages

window.SpreeStaticPages = Ember.Application.create
  LOG_BINDINGS: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  LOG_ACTIVE_GENERATION: true
  rootElement: "#static-pages-index"

#window.SpreeStaticPages.ApplicationSerializer = DS.ActiveModelSerializer.extend
