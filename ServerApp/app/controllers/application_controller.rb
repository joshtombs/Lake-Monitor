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

  def send_warning_email(conditions)
    contacts = Contactinfo.all
    recipients = Array.new
    contacts.each do |c|
      recipients << c.email
    end
    MessageMailer.send_warning(conditions, recipients).deliver_now
    flash[:alert] = "An unsafe condition was just posted!"
  end
end
