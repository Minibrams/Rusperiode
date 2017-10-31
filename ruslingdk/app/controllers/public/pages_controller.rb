class Public::PagesController < PublicApplicationController
  def show
    @page = @domain.posts.find_by(slug: params[:id])
  end
end
