class AccountActivationsController < ApplicationController
	skip_before_action :require_login
	def edit
		@user = User.find_by_email(params[:email])
		if @user and @user.activate(params[:id])
			flash[:success] = "Your account is now activated for use!"
		else
			flash[:alert] = "Invalid activation url."
		end
		redirect_to log_in_path
	end
end
