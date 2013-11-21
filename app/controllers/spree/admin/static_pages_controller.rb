class Spree::Admin::StaticPagesController < Spree::Admin::ResourceController
  def index

  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @static_page }
    end
  end
  def create
    page_params  = params.delete :spree_static_page
    @static_page = Spree::StaticPage.create page_params.slice(:name, :path, :active_on, :content)
    if @static_page.valid?
      render json: @static_page, status: :created
    else
      render json: @static_page.errors, status: :unprocessable_entity
    end
  end

  def update

  end
end
