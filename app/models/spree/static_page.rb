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
      validates_presence_of :text
    end
  end

  def text_html
    @text_html ||= text_markdown text_oembed text
    @text_html.strip
  end

  def text=(t)
    @text_html = nil
    super
  end

  protected
  def text_oembed(t)
    return if t.nil?
    t.gsub URL_RE do |url|
      provider = OEmbed::Providers.find $1
      provider ? provider.get(url).html : $1
    end
  end

  def text_markdown(t)
    markdown.render t
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
