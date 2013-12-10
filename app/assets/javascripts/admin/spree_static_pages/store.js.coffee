DS.RESTAdapter.reopen
  namespace: "admin"
  keyForAttribute: (attr) ->
    console.log "Deserializing #{attr} => #{Ember.String.decamelize(attr)}"
    Ember.String.decamelize attr

DS.ActiveModelSerializer.reopen
  keyForAttribute: (attr) ->
    console.log "AMS: Deserializing #{attr} => #{Ember.String.decamelize(attr)}"
    Ember.String.decamelize attr


window.SpreeStaticPages.store = DS.Store.create
  # Override the default adapter with the `DS.ActiveModelAdapter` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  adapter: '_ams'
  defaultSerializer: '_ams'
