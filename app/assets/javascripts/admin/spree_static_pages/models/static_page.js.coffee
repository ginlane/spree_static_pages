
window.SpreeStaticPages.StaticPage = DS.Model.extend
  previewUrl: DS.attr "string"
  approveUrl: DS.attr "string"
  disapproveUrl: DS.attr "string"

  activeOn: DS.attr "date"
  name: DS.attr "string"
  path: DS.attr "string"
  state: DS.attr "string"
  text: DS.attr "string"

# SpreeStaticPages.StaticPageSerializer = DS.ActiveModelSerializer
