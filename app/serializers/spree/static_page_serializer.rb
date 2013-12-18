class Spree::StaticPageSerializer < ActiveModel::Serializer
  attributes :id, :name, :path, :state, :activeOn, :text, :text_html, :created_at, :previewUrl, :approveUrl, :disapproveUrl
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

  def approveUrl
    controller.url_for controller: controller.params[:controller], action: :approve, id: @object.id
  end
  def disapproveUrl
    controller.url_for controller: controller.params[:controller], action: :disapprove, id: @object.id
  end
end
