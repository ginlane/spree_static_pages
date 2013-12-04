# http://emberjs.com/guides/models/using-the-store/


window.SpreeStaticPages.Store = DS.Store.extend
  # Override the default adapter with the `DS.ActiveModelAdapter` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  adapter: '_ams'


DS.ActiveModelAdapter.reopen
  namespace: "admin"

a = new DS.ActiveModelAdapter
console.log a.buildURL("static_page")