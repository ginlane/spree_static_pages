class Spree::Admin::StaticPagesController < Spree::Admin::ResourceController
  layout :pick_layout

  def index
    @static_page = Spree::StaticPage.new
    respond_to do |format|
      format.html
      format.json { render json: @static_pages, controller: self }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @static_page, controller: self }
    end
  end

  def edit
  end

  def create
    page_params               = params.delete :static_page
    page_params[:active_on] ||= page_params.delete :activeOn
    @static_page = Spree::StaticPage.create page_params.slice(:name, :path, :active_on, :text)
    if @static_page.valid?
      render json: @static_page, status: :created, controller: self
    else
      render json: @static_page.errors, status: :unprocessable_entity
    end
  end

  def update
    @static_page = Spree::StaticPage.find params[:id]
    page_params  = params.delete :static_page
    # TODO: update to autodecamelize all attrs
    page_params[:active_on] ||= page_params.delete :activeOn
    @static_page.update_attributes page_params.slice(:name, :path, :active_on, :text)
    if params[:approve].to_s == "true"
      @static_page.approve
    elsif params[:approve].to_s == "false"
      @static_page.disapprove
    end

    if @static_page.valid?
      render json: @static_page, status: :ok, controller: self
    else
      render json: @static_page.errors, status: :unprocessable_entity
    end
  end

  protected
  def pick_layout
    action_name == "show" ? "application" : "spree/layouts/admin"
  end

end
