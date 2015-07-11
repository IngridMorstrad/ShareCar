class PasswordResetsController < ApplicationController
	skip_before_action :require_login

	def new
	end

	def index
	end

	def create
	  if params[:email].to_s == ''
	  	flash.now[:warning] = "Email field is blank."
	  	render "index"
	  else
	    params[:email] = params[:email].downcase
	    @user = User.find_by_email(params[:email])
	    @user.send_password_reset if @user
	    flash[:info] = "Email sent with password reset instructions."
	    redirect_to log_in_path
	  end
	end

	def edit
	  @user = User.find_by_password_reset_token!(params[:id])
	  if !(@user)
	  	flash[:warning] = "User not found!"
	  	redirect_to password_resets_path
	  end
	end

	def update
	  @user = User.find_by_password_reset_token!(params[:id])
	  if @user.password_reset_sent_at < 2.hours.ago
	  	flash[:danger] = "Password reset has expired."
	    redirect_to password_resets_path
	  elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation)) #TODO: Make it safer.
	  	flash[:success] = "Password has been reset!"
	    redirect_to log_in_path
	  else
	    render :edit
	  end
	end
end
