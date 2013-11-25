class Spree::Admin::StaticPagesController < Spree::Admin::ResourceController
  def index
    @static_page = Spree::StaticPage.new
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @static_page }
    end
  end

  def edit
  end

  def create
    page_params  = params.delete :static_page
    @static_page = Spree::StaticPage.create page_params.slice(:name, :path, :active_on, :content)
    if @static_page.valid?
      render json: @static_page, status: :created
    else
      render json: @static_page.errors, status: :unprocessable_entity
    end
  end

  def update
    @static_page = Spree::StaticPage.find params[:id]
    page_params  = params.delete :static_page
    @static_page.update_attributes page_params.slice(:name, :path, :active_on, :content)
    if params[:publish]
      @static_page.approve!
    end
    if @static_page.valid?
      render json: @static_page, status: :ok
    else
      render json: @static_page.errors, status: :unprocessable_entity
    end
  end
end
