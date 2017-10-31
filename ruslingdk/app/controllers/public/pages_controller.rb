class Public::PagesController < PublicApplicationController
  def show
    @page = @domain.pages.find_by(slug: params[:id])
  end
end
