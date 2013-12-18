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
    page_params  = uncamelize params.delete(:static_page)

    @static_page.update_attributes page_params.slice(:name, :path, :active_on, :text)

    @static_page.valid?? render_success : render_failure
  end

  def approve
    @static_page = Spree::StaticPage.find params[:id]
    @static_page.approve ? render_success : render_failure
  end

  def disapprove
    @static_page = Spree::StaticPage.find params[:id]
    @static_page.disapprove ? render_success : render_failure
  end

  protected
  def pick_layout
    action_name == "show" ? "application" : "spree/layouts/admin"
  end

  def render_success
    render json: @static_page, status: :ok, controller: self
  end

  def render_failure
    render json: @static_page.errors, status: :unprocessable_entity, controller: self
  end

  def uncamelize(params)
    params.inject({ }) do |acc, (k, v)|
      acc[k.to_s.underscore] = v
      acc
    end.with_indifferent_access
  end
end
