class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

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
      flash[:success] = "Welcome #{current_user.name}!"
  		redirect_to trips_path
  	else
  		flash.now[:alert] = "Incorrect email or password"
  		render 'new'
  	end
  end

  def destroy
    cookies.delete(:auth_token)
  	redirect_to root_path
  end
end
