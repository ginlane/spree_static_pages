(function() {
  var handle_ajax_error, handle_create, handle_delete, handle_move, handle_rename, root;

  handle_ajax_error = function(XMLHttpRequest, textStatus, errorThrown) {
    $.jstree.rollback(last_rollback);
    return $("#ajax_error").show().html("<strong>" + server_error + "</strong><br />" + taxonomy_tree_error);
  };

  handle_move = function(e, data) {
    var last_rollback, new_parent, node, position, url;
    last_rollback = data.rlbk;
    position = data.rslt.cp;
    node = data.rslt.o;
    new_parent = data.rslt.np;
    url = Spree.url(base_url).clone();
    url.setPath(url.path() + '/' + node.attr("id"));
    $.ajax({
      type: "POST",
      dataType: "json",
      url: url.toString(),
      data: {
        _method: "put",
        "taxon[parent_id]": new_parent.attr("id"),
        "taxon[position]": position
      },
      error: handle_ajax_error
    });
    return true;
  };

  handle_create = function(e, data) {
    var last_rollback, name, new_parent, node, position;
    last_rollback = data.rlbk;
    node = data.rslt.obj;
    name = data.rslt.name;
    position = data.rslt.position;
    new_parent = data.rslt.parent;
    return $.ajax({
      type: "POST",
      dataType: "json",
      url: base_url.toString(),
      data: {
        "taxon[name]": name,
        "taxon[parent_id]": new_parent.attr("id"),
        "taxon[position]": position
      },
      error: handle_ajax_error,
      success: function(data, result) {
        return node.attr('id', data.id);
      }
    });
  };

  handle_rename = function(e, data) {
    var last_rollback, name, node, url;
    last_rollback = data.rlbk;
    node = data.rslt.obj;
    name = data.rslt.new_name;
    url = Spree.url(base_url).clone();
    url.setPath(url.path() + '/' + node.attr("id"));
    return $.ajax({
      type: "POST",
      dataType: "json",
      url: url.toString(),
      data: {
        _method: "put",
        "taxon[name]": name
      },
      error: handle_ajax_error
    });
  };

  handle_delete = function(e, data) {
    var delete_url, last_rollback, node;
    last_rollback = data.rlbk;
    node = data.rslt.obj;
    delete_url = base_url.clone();
    delete_url.setPath(delete_url.path() + '/' + node.attr("id"));
    return jConfirm(Spree.translations.are_you_sure_delete, Spree.translations.confirm_delete, function(r) {
      if (r) {
        return $.ajax({
          type: "POST",
          dataType: "json",
          url: delete_url.toString(),
          data: {
            _method: "delete"
          },
          error: handle_ajax_error
        });
      } else {
        $.jstree.rollback(last_rollback);
        return last_rollback = null;
      }
    });
  };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.setup_taxonomy_tree = function(taxonomy_id) {
    if (taxonomy_id !== void 0) {
      root.base_url = Spree.url(Spree.routes.taxonomy_taxons_path);
      $.ajax({
        url: base_url.path().replace("/taxons", "/jstree"),
        success: function(taxonomy) {
          var conf, last_rollback;
          last_rollback = null;
          conf = {
            json_data: {
              data: taxonomy,
              ajax: {
                url: function(e) {
                  return base_url.path() + '/' + e.attr('id') + '/jstree';
                }
              }
            },
            themes: {
              theme: "apple",
              url: "/assets/jquery.jstree/themes/apple/style.css"
            },
            strings: {
              new_node: new_taxon,
              loading: Spree.translations.loading + "..."
            },
            crrm: {
              move: {
                check_move: function(m) {
                  var new_parent, node, position;
                  position = m.cp;
                  node = m.o;
                  new_parent = m.np;
                  if (!new_parent || node.attr("rel") === "root") {
                    return false;
                  }
                  if (new_parent.attr("id") === "taxonomy_tree" && position === 0) {
                    return false;
                  }
                  return true;
                }
              }
            },
            contextmenu: {
              items: function(obj) {
                return taxon_tree_menu(obj, this);
              }
            },
            plugins: ["themes", "json_data", "dnd", "crrm", "contextmenu"]
          };
          return $("#taxonomy_tree").jstree(conf).bind("move_node.jstree", handle_move).bind("remove.jstree", handle_delete).bind("create.jstree", handle_create).bind("rename.jstree", handle_rename).bind("loaded.jstree", function() {
            return $(this).jstree("core").toggle_node($('.jstree-icon').first());
          });
        }
      });
      $("#taxonomy_tree a").on("dblclick", function(e) {
        return $("#taxonomy_tree").jstree("rename", this);
      });
      return $(document).keypress(function(e) {
        if (e.keyCode === 13) {
          return e.preventDefault();
        }
      });
    }
  };

}).call(this);
