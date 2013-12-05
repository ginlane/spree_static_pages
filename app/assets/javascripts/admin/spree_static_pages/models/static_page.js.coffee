
window.SpreeStaticPages.StaticPage = DS.Model.extend
  activeOn: DS.attr "date"
  name: DS.attr "string"
  path: DS.attr "string"
  state: DS.attr "string"
  content: DS.attr "string"