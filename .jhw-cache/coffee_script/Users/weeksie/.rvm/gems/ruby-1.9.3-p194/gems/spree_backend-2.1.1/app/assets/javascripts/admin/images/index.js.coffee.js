(function() {
  $(function() {
    return ($('#new_image_link')).click(function(event) {
      event.preventDefault();
      ($('.no-objects-found')).hide();
      ($(this)).hide();
      return $.ajax({
        type: 'GET',
        url: this.href,
        data: {
          authenticity_token: AUTH_TOKEN
        },
        success: function(r) {
          return ($('#images')).html(r);
        }
      });
    });
  });

}).call(this);
