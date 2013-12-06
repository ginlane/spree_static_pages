(function() {
  $(document).ready(function() {
    var opts, target;
    opts = {
      lines: 11,
      length: 2,
      width: 3,
      radius: 9,
      corners: 1,
      rotate: 0,
      color: '#fff',
      speed: 0.8,
      trail: 48,
      shadow: false,
      hwaccel: true,
      className: 'spinner',
      zIndex: 2e9,
      top: 'auto',
      left: 'auto'
    };
    target = document.getElementById("spinner");
    $(document).ajaxStart(function() {
      var spinner;
      $("#progress").fadeIn();
      return spinner = new Spinner(opts).spin(target);
    });
    return $(document).ajaxStop(function() {
      return $("#progress").fadeOut();
    });
  });

}).call(this);
