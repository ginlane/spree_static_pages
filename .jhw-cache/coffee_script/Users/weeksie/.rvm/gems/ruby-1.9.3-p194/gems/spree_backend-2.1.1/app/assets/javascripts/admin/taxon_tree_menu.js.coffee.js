(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.taxon_tree_menu = function(obj, context) {
    var admin_base_url, base_url, edit_url;
    base_url = Spree.url(Spree.routes.taxonomy_taxons_path);
    admin_base_url = Spree.url(Spree.routes.admin_taxonomy_taxons_path);
    edit_url = admin_base_url.clone();
    edit_url.setPath(edit_url.path() + '/' + obj.attr("id") + "/edit");
    return {
      create: {
        label: "<i class='icon-plus'></i> " + Spree.translations.add,
        action: function(obj) {
          return context.create(obj);
        }
      },
      rename: {
        label: "<i class='icon-pencil'></i> " + Spree.translations.rename,
        action: function(obj) {
          return context.rename(obj);
        }
      },
      remove: {
        label: "<i class='icon-trash'></i> " + Spree.translations.remove,
        action: function(obj) {
          return context.remove(obj);
        }
      },
      edit: {
        separator_before: true,
        label: "<i class='icon-edit'></i> " + Spree.translations.edit,
        action: function(obj) {
          return window.location = edit_url.toString();
        }
      }
    };
  };

}).call(this);
