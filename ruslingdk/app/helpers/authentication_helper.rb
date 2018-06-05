# frozen_string_literal: true

module AuthenticationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def current_user=(user)
    @current_user = user                   if user.is_a?(User)
    @current_user = User.find_by(id: user) if user.is_a?(Integer)
    session[:user_id] = @current_user&.id
  end

  def require_logged_in
    access_denied if current_user.blank?
  end

  def require_not_logged_in
    redirect_to dashboard_path if current_user.is_a?(User)
  end

  def authenticate_admin_user!
    return true if current_user.domain_admin?
    return true if current_user.system_admin?
    redirect_to root_path
  end

  def access_denied(_)
    flash[:error] = 'Login required'
    redirect_to root_path
  end
end
