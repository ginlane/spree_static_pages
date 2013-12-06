(function() {
  window.Spree = (function() {
    function Spree() {}

    Spree.ready = function(callback) {
      return jQuery(document).ready(callback);
    };

    Spree.url = function(uri, query) {
      if (uri.path === void 0) {
        uri = new Uri(uri);
      }
      if (query) {
        $.each(query, function(key, value) {
          return uri.addQueryParam(key, value);
        });
      }
      if (Spree.api_key) {
        uri.addQueryParam('token', Spree.api_key);
      }
      return uri;
    };

    Spree.uri = function(uri, query) {
      return url(uri, query);
    };

    Spree.ajax = function(url_or_settings, settings) {
      var url;
      if (typeof url_or_settings === "string") {
        return $.ajax(Spree.url(url_or_settings).toString(), settings);
      } else {
        url = url_or_settings['url'];
        delete url_or_settings['url'];
        return $.ajax(Spree.url(url).toString(), url_or_settings);
      }
    };

    return Spree;

  })();

}).call(this);
