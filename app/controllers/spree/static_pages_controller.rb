class ::Spree::StaticPagesController < ApplicationController
  def show
    @static_page = ::Spree::StaticPage.live.find_by_path! params[:path]
  end
end
