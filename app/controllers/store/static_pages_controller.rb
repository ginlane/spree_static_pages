
class Store::StaticPagesController < ApplicationController
  def show
    @static_page = Spree::StaticPage.approved.find_by_path! params[:path]
  end
end
