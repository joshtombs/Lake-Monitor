class SessionsController < ApplicationController

  def new
  end

  def create
    #admin = Admins.where(:username => params[:admin][:username].downcase).first
    admin = Admins.find_by_username(params[:admin][:username])
    if admin && admin.authenticate(params[:admin][:password_digest])
      session[:admin_id] = admin.id
      redirect_to '/sensordata'
      flash[:notice] ="Login successful!"
    else
      redirect_to '/admin_login'
      flash[:notice] ="Login unsuccessful, please try again."
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to '/sensordata'
  end
end