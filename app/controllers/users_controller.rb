class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)
    if @user.save
      flash[:notice] = "Successfully created account!"
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = "There was a problem in creating your account! Please, Try again."
      render 'new'
    end
  end

  private
  def user_create_params
    params.require(:user).permit(:email, :password)
  end
end
