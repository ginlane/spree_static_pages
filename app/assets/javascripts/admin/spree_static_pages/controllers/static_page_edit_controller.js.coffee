window.SpreeStaticPages.StaticPagesEditController = Ember.ObjectController.extend Ember.Evented, SpreeStaticPages.PageSaver,
  isNew: false
  previewUrl: -> @get("model").get("previewUrl")
