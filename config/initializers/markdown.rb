require'redcarpet'
MARKDOWN = Redcarpet::Markdown.new Redcarpet::Render::HTML, no_intra_emphasis: true, highlight: true, strikethrough: true, lax_spacing: true
