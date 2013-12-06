(function() {
  window.SpreeStaticPages.Router.reopen({
    rootURL: "/admin"
  });

  window.SpreeStaticPages.Router.map(function() {
    return this.resource('static_page', {
      path: "static_pages"
    }, function() {
      return this.route("edit", {
        path: "/edit/:static_page_id"
      });
    });
  });

  window.SpreeStaticPages.IndexRoute = Ember.Route.extend({
    templateName: "admin/spree_static_pages/index",
    model: function() {
      return this.store.find("static_page");
    }
  });

  window.SpreeStaticPages.StaticPageEditRoute = Ember.Route.extend({
    templateName: "admin/spree_static_pages/static_page/edit",
    renderTemplate: function() {
      return this.render(this.templateName, {
        controller: this.controllerFor("static_page.edit")
      });
    },
    model: function(params) {
      return this.store.find("static_page", params.static_page_id);
    }
  });

}).call(this);
