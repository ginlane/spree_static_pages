(function() {
  console.log(Handlebars.COMPILER_REVISION);

  window.App = window.SpreeStaticPages;

  App.setupForTesting();

  App.injectTestHelpers();

}).call(this);
