#= require admin/spree_backend
#= require admin/spree_static_pages_editor

$(document).ready ->
  window.pageEditor = new StaticPageEditor("form.static-page-form")
