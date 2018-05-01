class Public::SessionsController < PublicApplicationController
  # skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  def destroy
    self.current_user = nil

    redirect_to root_path
  end

protected

  def auth_hash
    request.env['omniauth.auth'] || params
  end
end
