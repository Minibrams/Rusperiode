class Public::PagesController < PublicApplicationController
  def show
    @page = params[:page].present? ? @domain.pages.find_by(slug: params[:page]) : @domain.default_page
  end
  def menu
    @page = params[:page].present? ? @domain.pages.find_by(slug: params[:page]) : @domain.default_page
  end
end
