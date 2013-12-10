class Spree::StaticPageSerializer < ActiveModel::Serializer
  attributes :id, :name, :path, :state, :activeOn, :text, :text_html, :created_at, :previewUrl#, :url
  attr_accessor :controller

  def initialize(resource, options)
    self.controller = options[:controller]
    super
  end

  def state
    @object.state.humanize
  end

  def activeOn
    @object.active_on.try :strftime, "%Y/%m/%d"
  end

  def previewUrl
    controller.url_for [ :admin,  @object ]
  end
end
