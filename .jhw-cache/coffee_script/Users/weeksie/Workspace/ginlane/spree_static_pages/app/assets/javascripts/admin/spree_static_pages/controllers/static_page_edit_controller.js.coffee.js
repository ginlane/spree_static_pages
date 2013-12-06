(function() {
  window.SpreeStaticPages.StaticPageEditController = Ember.ObjectController.extend({
    actions: {
      save: function() {
        var fail, page, succ,
          _this = this;
        page = this.get("model");
        succ = function(savedPage) {
          return _this.transitionToRoute("static_page.edit", savedPage);
        };
        fail = function() {
          return alert("GAGAGASDFASDFASDFASDFASDF");
        };
        return page.save().then(succ, fail);
      }
    }
  });

}).call(this);
