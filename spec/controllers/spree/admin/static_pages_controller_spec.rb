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
      spree_post :create, static_page: FactoryGirl.attributes_for(:static_page)
      response.should be_success
    }.to change(Spree::StaticPage, :count).by(1)
  end

  it "should validate approval" do
    attrs  = FactoryGirl.create(:static_page, name: nil).attributes.with_indifferent_access
    id     = attrs.delete :id
    spree_put :update, id: id, static_page: attrs, approve: true
    assigns(:static_page).should be_draft
  end
end
