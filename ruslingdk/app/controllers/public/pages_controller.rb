class Public::PagesController < PublicApplicationController
  before_action :find_page

  def show
    render @page.view_file
  end

private

  def find_page
    @page = params[:slug].present? ? @domain.pages.find_by(slug: params[:slug]) : @domain.default_page
  end
end
