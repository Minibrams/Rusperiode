class Public::PagesController < PublicApplicationController
  def show
    @page = params[:id].present? ? @domain.pages.find_by(slug: params[:id]) : @domain.default_page
  end
end
