(function() {
  window.SpreeStaticPages.Store = DS.Store.extend({
    adapter: '_ams'
  });

  DS.ActiveModelAdapter.reopen({
    namespace: "admin"
  });

}).call(this);
