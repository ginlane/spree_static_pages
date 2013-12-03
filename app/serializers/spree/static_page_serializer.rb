class Spree::StaticPageSerializer < ActiveModel::Serializer
  attributes :id, :name, :path, :state, :active_on, :content, :created_at, :url, :edit_url
  attr_accessor :controller

  def initialize(resource, options)
    self.controller = options[:controller]
    super
  end
  def state
    @object.state.humanize
  end
  def active_on
    @object.active_on.try :strftime, "%Y/%m/%d"
  end

  def edit_url
    controller.url_for id: @object.id, action: "edit"
  end
  def url
    controller.url_for [ :admin, @object ]
  end
end
