class Spree::StaticPage < ActiveRecord::Base
  before_save :sanitize_path

  scope :live, -> {
    approved.where [ "active_on < ?", Time.now ]
  }
  scope :approved, -> {
    where state: "approved"
  }
  scope :draft, -> {
    where state: "draft"
  }

  URL_RE = /(https?:\/\/[^\s]+)/
  state_machine initial: :draft do
    event :approve do
      transition any => :approved
    end

    event :disapprove do
      transition any => :draft
    end

    state :approved do
      validates_presence_of :name
      validates_presence_of :path
      validates_presence_of :content
    end
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
    return if text.nil?
    text.gsub URL_RE do |url|
      provider = OEmbed::Providers.find $1
      provider ? provider.get(url).html : $1
    end
  end

  def content_markdown(text)
    markdown.render text
  end

  def markdown
    MARKDOWN
  end

  def sanitize_path
    if path[0] == "/"
      path.slice! 1, path.length
    end
    self.path = URI(path).normalize.path
  end
end
