class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.send_activation_email
      flash[:success] = "Succesfully created account and activation email sent with instructions."
      redirect_to log_in_path
    else
      flash.now[:danger] = "There was a problem in creating your account! Please, Try again."
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
