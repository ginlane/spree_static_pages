require 'spec_helper'

describe Spree::Admin::StaticPagesController do
  before :each do
    @user = FactoryGirl.create :admin_user
    controller.stubs(:spree_current_user).returns @user
  end

  it "should respond with rendered html" do
    @page = FactoryGirl.create :static_page
    spree_get :show, id: @page.id, format: :json
    JSON.parse(response.body)["content"].should eql @page.content_html
  end

  it "should create some shiz" do
    expect {
      spree_post :create, spree_static_page: FactoryGirl.attributes_for(:static_page)
      response.should be_success
    }.to change(Spree::StaticPage, :count).by(1)
  end
end
