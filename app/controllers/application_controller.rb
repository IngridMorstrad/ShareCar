class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :require_login, except: :clock
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
  	@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  private
  def require_login
  	unless current_user
  		flash[:error] = "You aren't logged in"
  		redirect_to log_in_path
  	end
  end

end
