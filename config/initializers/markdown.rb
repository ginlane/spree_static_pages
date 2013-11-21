require'redcarpet'
Spree::StaticPage.configure_markdown do |page|
  page.markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML, no_intra_emphasis: true, highlight: true, strikethrough: true, lax_spacing: true
end
