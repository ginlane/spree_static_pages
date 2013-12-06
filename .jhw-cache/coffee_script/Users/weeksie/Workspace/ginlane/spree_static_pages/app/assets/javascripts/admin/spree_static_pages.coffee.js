(function() {
  window.SpreeStaticPages = Ember.Application.create({
    LOG_BINDINGS: true,
    LOG_TRANSITIONS: true,
    LOG_TRANSITIONS_INTERNAL: true,
    LOG_VIEW_LOOKUPS: true,
    LOG_ACTIVE_GENERATION: true,
    rootElement: "#static-pages-index"
  });

}).call(this);
