(function() {
  window.SpreeStaticPages.IndexController = Ember.ArrayController.extend({
    model: function() {
      return this.store.find("static_page");
    }
  });

}).call(this);
