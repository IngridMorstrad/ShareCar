class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if user
      cookies[:user_id] = user.id
      redirect_to_root_path
    else

      if params[:email].to_s == '' or params[:password].to_s == ''
        flash.now[:warning] = "Email and/or Password field is blank."
        render "new"
      else
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
          flash.now[:danger] = "Incorrect email or password"
          render 'new'
        end
      end
    end
  end

  def destroy
    if current_user
      cookies.delete(:auth_token)
      @current_user = nil
    end
    redirect_to root_path
  end
end
