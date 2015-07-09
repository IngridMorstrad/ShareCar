class PasswordResetsController < ApplicationController
	skip_before_action :require_login

	def new
	end

	def index
	end

	def create
	  if params[:email].to_s == ''
	  	flash.now[:alert] = "Email field is blank."
	  	render "index"
	  else
	    params[:email] = params[:email].downcase
	    @user = User.find_by_email(params[:email])
	    @user.send_password_reset if @user
	    redirect_to log_in_path, :notice => "Email sent with password reset instructions."
	  end
	end

	def edit
	  @user = User.find_by_password_reset_token!(params[:id])
	  if !(@user)
	  	redirect_to password_resets_path, :notice => "User not found!"
	  end
	end

	def update
	  @user = User.find_by_password_reset_token!(params[:id])
	  if @user.password_reset_sent_at < 2.hours.ago
	    redirect_to password_resets_path, :alert => "Password reset has expired."
	  elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation)) #TODO: Make it safer.
	    redirect_to log_in_path, :notice => "Password has been reset!"
	  else
	    render :edit
	  end
	end
end
