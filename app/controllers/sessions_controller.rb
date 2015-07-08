class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    params[:email] = params[:email].downcase
    user = User.find_by_email(params[:email])
  	if user and User.authenticate(params[:email],params[:password]) and user.is_activated?
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      flash[:success] = "Welcome #{current_user.name}!"
  		redirect_to trips_path
  	else
  		flash.now[:alert] = "Incorrect email or password"
  		render 'new'
  	end
  end

  def destroy
    cookies.delete(:auth_token)
    flash[:success] = "Logged out!"
  	redirect_to log_in_path
  end
end
