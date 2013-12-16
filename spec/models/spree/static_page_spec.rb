require 'spec_helper'

describe Spree::StaticPage do
  it "should run oemebeds on text" do
    page             = Spree::StaticPage.new
    page.text     = "Video: http://www.youtube.com/watch?v=kbGVIdA3dx0"
    expected_text = "<p>Video: #{OEmbed::Providers::Youtube.get("http://www.youtube.com/watch?v=kbGVIdA3dx0").html}</p>"

    page.text_html.should eql expected_text
  end

  it "should run markdown on text" do
    page             = Spree::StaticPage.new
    page.text     = "Video: http://www.youtube.com/watch?v=kbGVIdA3dx0 *italics*"
    expected_text = "<p>Video: #{OEmbed::Providers::Youtube.get("http://www.youtube.com/watch?v=kbGVIdA3dx0").html} <em>italics</em></p>"
    page.text_html.should eql expected_text
  end

  it "should validate based on state" do
    page         = Spree::StaticPage.new
    page.valid?.should be_true
    page.approve.should be_false

    page.path    = "/path"
    page.text = "Wordz"
    page.name    = "Path"
    page.approve.should be_true
  end

  it "shuold not fuckup path sanitizing" do
    page = Spree::StaticPage.new
    page.name = "Fnord"
    page.text = "TEXT"
    page.path = "/pathpathpath"
    page.save
    page.path.should eql "pathpathpath"
  end
end
