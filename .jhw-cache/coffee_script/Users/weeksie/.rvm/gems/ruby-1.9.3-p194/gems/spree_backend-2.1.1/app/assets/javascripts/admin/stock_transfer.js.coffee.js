(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $(function() {
    var TransferAddVariants, TransferLocations, TransferStockItem, TransferVariant, TransferVariants, transfer_add_variants, transfer_locations, transfer_variants;
    TransferVariant = (function() {
      function TransferVariant(variant) {
        this.variant = variant;
        this.id = this.variant.id;
        this.name = "" + this.variant.name + " - " + this.variant.sku;
        this.quantity = 0;
      }

      TransferVariant.prototype.add = function(quantity) {
        return this.quantity += quantity;
      };

      return TransferVariant;

    })();
    TransferStockItem = (function(_super) {
      __extends(TransferStockItem, _super);

      function TransferStockItem(stock_item) {
        this.stock_item = stock_item;
        TransferStockItem.__super__.constructor.call(this, this.stock_item.variant);
        this.count_on_hand = this.stock_item.count_on_hand;
        this.name = "" + this.variant.name + " - " + this.variant.sku + " (" + this.count_on_hand + ")";
      }

      TransferStockItem.prototype.add = function(quantity) {
        this.quantity += quantity;
        if (this.quantity > this.count_on_hand) {
          return this.quantity = this.count_on_hand;
        }
      };

      return TransferStockItem;

    })(TransferVariant);
    TransferLocations = (function() {
      function TransferLocations() {
        var _this = this;
        this.source = $('#transfer_source_location_id');
        this.destination = $('#transfer_destination_location_id');
        this.source.change(function() {
          return _this.populate_destination();
        });
        $('#transfer_receive_stock').change(function(event) {
          return _this.receive_stock_change(event);
        });
        $.getJSON(Spree.routes.stock_locations_api, function(data) {
          var location;
          _this.locations = (function() {
            var _i, _len, _ref, _results;
            _ref = data.stock_locations;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              location = _ref[_i];
              _results.push(location);
            }
            return _results;
          })();
          if (_this.locations.length < 2) {
            _this.force_receive_stock();
          }
          _this.populate_source();
          return _this.populate_destination();
        });
      }

      TransferLocations.prototype.force_receive_stock = function() {
        $('#receive_stock_field').hide();
        $('#transfer_receive_stock').prop('checked', true);
        return this.toggle_source_location(true);
      };

      TransferLocations.prototype.is_source_location_hidden = function() {
        return $('#transfer_source_location_id_field').css('visibility') === 'hidden';
      };

      TransferLocations.prototype.toggle_source_location = function(hide) {
        if (hide == null) {
          hide = false;
        }
        this.source.trigger('change');
        if (this.is_source_location_hidden() && !hide) {
          return $('#transfer_source_location_id_field').css('visibility', 'visible');
        } else {
          return $('#transfer_source_location_id_field').css('visibility', 'hidden');
        }
      };

      TransferLocations.prototype.receive_stock_change = function(event) {
        this.toggle_source_location(event.target.checked);
        return this.populate_destination(!event.target.checked);
      };

      TransferLocations.prototype.populate_source = function() {
        this.populate_select(this.source);
        return this.source.trigger('change');
      };

      TransferLocations.prototype.populate_destination = function(except_source) {
        if (except_source == null) {
          except_source = true;
        }
        if (this.is_source_location_hidden()) {
          return this.populate_select(this.destination);
        } else {
          return this.populate_select(this.destination, parseInt(this.source.val()));
        }
      };

      TransferLocations.prototype.populate_select = function(select, except) {
        var location, _i, _len, _ref;
        if (except == null) {
          except = 0;
        }
        select.children('option').remove();
        _ref = this.locations;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          location = _ref[_i];
          if (location.id !== except) {
            select.append($('<option></option>').text(location.name).attr('value', location.id));
          }
        }
        return select.select2();
      };

      return TransferLocations;

    })();
    TransferVariants = (function() {
      function TransferVariants() {
        var _this = this;
        $('#transfer_source_location_id').change(function() {
          return _this.refresh_variants();
        });
      }

      TransferVariants.prototype.receiving_stock = function() {
        return $("#transfer_receive_stock:checked").length > 0;
      };

      TransferVariants.prototype.refresh_variants = function() {
        if (this.receiving_stock()) {
          return this._refresh_transfer_variants();
        } else {
          return this._refresh_transfer_stock_items();
        }
      };

      TransferVariants.prototype._refresh_transfer_variants = function() {
        var _this = this;
        if (this.cached_variants != null) {
          return this.populate_select(this.cached_variants);
        } else {
          return $.getJSON(Spree.routes.variants_api, function(data) {
            _this.cached_variants = _.map(data.variants, function(variant) {
              return new TransferVariant(variant);
            });
            return _this.populate_select(_this.cached_variants);
          });
        }
      };

      TransferVariants.prototype._refresh_transfer_stock_items = function() {
        var stock_location_id,
          _this = this;
        stock_location_id = $('#transfer_source_location_id').val();
        return $.getJSON(Spree.routes.stock_locations_api + ("/" + stock_location_id + "/stock_items"), function(data) {
          return _this.populate_select(_.map(data.stock_items, function(stock_item) {
            return new TransferStockItem(stock_item);
          }));
        });
      };

      TransferVariants.prototype.populate_select = function(variants) {
        var variant, _i, _len;
        $('#transfer_variant').children('option').remove();
        for (_i = 0, _len = variants.length; _i < _len; _i++) {
          variant = variants[_i];
          $('#transfer_variant').append($('<option></option>').text(variant.name).attr('value', variant.id).data('variant', variant));
        }
        return $('#transfer_variant').select2();
      };

      return TransferVariants;

    })();
    TransferAddVariants = (function() {
      function TransferAddVariants() {
        var _this = this;
        this.variants = [];
        this.template = Handlebars.compile($('#transfer_variant_template').html());
        $('#transfer_source_location_id').change(function(event) {
          return _this.clear_variants();
        });
        $('button.transfer_add_variant').click(function(event) {
          event.preventDefault();
          return _this.add_variant();
        });
        $('#transfer-variants-table').on('click', '.transfer_remove_variant', function(event) {
          event.preventDefault();
          return _this.remove_variant($(event.target));
        });
        $('button.transfer_transfer').click(function() {
          if (!(_this.variants.length > 0)) {
            alert('no variants to transfer');
            return false;
          }
        });
      }

      TransferAddVariants.prototype.add_variant = function() {
        var quantity, variant;
        variant = $('#transfer_variant option:selected').data('variant');
        quantity = parseInt($('#transfer_variant_quantity').val());
        variant = this.find_or_add(variant);
        variant.add(quantity);
        return this.render();
      };

      TransferAddVariants.prototype.find_or_add = function(variant) {
        var existing;
        if (existing = _.find(this.variants, function(v) {
          return v.id === variant.id;
        })) {
          return existing;
        } else {
          variant = $.extend({}, variant);
          this.variants.push(variant);
          return variant;
        }
      };

      TransferAddVariants.prototype.remove_variant = function(target) {
        var v, variant_id;
        variant_id = parseInt(target.data('variantId'));
        this.variants = (function() {
          var _i, _len, _ref, _results;
          _ref = this.variants;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            v = _ref[_i];
            if (v.id !== variant_id) {
              _results.push(v);
            }
          }
          return _results;
        }).call(this);
        return this.render();
      };

      TransferAddVariants.prototype.clear_variants = function() {
        this.variants = [];
        return this.render();
      };

      TransferAddVariants.prototype.contains = function(id) {
        return _.contains(_.pluck(this.variants, 'id'), id);
      };

      TransferAddVariants.prototype.render = function() {
        var rendered;
        if (this.variants.length === 0) {
          $('#transfer-variants-table').hide();
          return $('.no-objects-found').show();
        } else {
          $('#transfer-variants-table').show();
          $('.no-objects-found').hide();
          rendered = this.template({
            variants: this.variants
          });
          return $('#transfer_variants_tbody').html(rendered);
        }
      };

      return TransferAddVariants;

    })();
    if ($('#transfer_source_location_id').length > 0) {
      transfer_locations = new TransferLocations;
      transfer_variants = new TransferVariants;
      return transfer_add_variants = new TransferAddVariants;
    }
  });

}).call(this);
