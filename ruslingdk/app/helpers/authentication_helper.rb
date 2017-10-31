# frozen_string_literal: true

module AuthenticationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def current_user=(u)
    @current_user ||= u if u.is_a?(User)
    @current_user ||= User.find_by(id: u) if u.is_a?(Integer)
    session[:user_id] = @current_user&.id
  end

  def require_logged_in
    return unless current_user.nil?
    flash[:error] = 'Login required'
    redirect_to root_path
  end

  def require_not_logged_in
    redirect_to dashboard_path if current_user.is_a?(User)
  end
end
