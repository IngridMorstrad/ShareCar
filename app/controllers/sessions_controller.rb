class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
  	if user and User.authenticate(params[:email],params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
  		redirect_to root_path, :notice => "Logged in!"
  	else
  		flash[:alert] = "There was a problem logging you in"
  		redirect_to log_in_path
  	end
  end

  def destroy
    cookies.delete(:auth_token)
  	redirect_to log_in_path, :notice => "Logged out!"
  end
end
