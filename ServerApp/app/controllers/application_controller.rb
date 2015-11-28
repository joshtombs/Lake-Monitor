class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_admin
    @current_admin ||= Admins.find(session[:admin_id]) if session[:admin_id]
  end
  helper_method :current_admin

  def authorize
    redirect_to '/admin_login' unless current_admin
  end
end
