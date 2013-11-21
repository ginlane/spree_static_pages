class Spree::StaticPage < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :path

  URL_RE = /(https?:\/\/[^\s]+)/
  cattr_accessor :markdown

  def self.configure_markdown
    yield self
  end

  def content_html
    @content_html ||= content_markdown content_oembed content
    @content_html.strip
  end

  def content=(content)
    @content_html = nil
    super
  end

  def as_json(options = { })
    super.merge content: content_html
  end

  protected
  def content_oembed(text)
    text.gsub URL_RE do |url|
      provider = OEmbed::Providers.find $1
      provider ? provider.get(url).html : $1
    end
  end

  def content_markdown(text)
    markdown.render text
  end

  def markdown
    self.class.markdown
  end
end
