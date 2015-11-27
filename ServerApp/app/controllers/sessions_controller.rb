class SessionsController < ApplicationController

  def new
  end

  def create
    admin = Admin.find_by_username(params[:username])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to '/sensordata'
    else
      redirect_to '/admin_login'
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to '/sensordata'
  end
end