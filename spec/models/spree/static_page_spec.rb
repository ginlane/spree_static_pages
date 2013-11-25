require 'spec_helper'

describe Spree::StaticPage do
  it "should run oemebeds on content" do
    page             = Spree::StaticPage.new
    page.content     = "Video: http://www.youtube.com/watch?v=kbGVIdA3dx0"
    expected_content = "<p>Video: #{OEmbed::Providers::Youtube.get("http://www.youtube.com/watch?v=kbGVIdA3dx0").html}</p>"

    page.content_html.should eql expected_content
  end

  it "should run markdown on content" do
    page             = Spree::StaticPage.new
    page.content     = "Video: http://www.youtube.com/watch?v=kbGVIdA3dx0 *italics*"
    expected_content = "<p>Video: #{OEmbed::Providers::Youtube.get("http://www.youtube.com/watch?v=kbGVIdA3dx0").html} <em>italics</em></p>"
    page.content_html.should eql expected_content
  end

  it "should validate based on state" do
    page         = Spree::StaticPage.new
    page.valid?.should be_true
    page.approve.should be_false

    page.path    = "/path"
    page.content = "Wordz"
    page.name    = "Path"
    page.approve.should be_true
  end
end
