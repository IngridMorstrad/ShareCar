class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	@user.created_at = Time.now.inspect
  	@user.updated_at = Time.now.inspect
  	if @user.save
  		print "WASAAAAAAP"
  		redirect_to(:action => 'login')
  	else
  		render 'new'
  	end
  end

  def home
  	@user = User.new(user_params)
  	if !(User.exists?(:name => @user.name, :email => @user.email))
  		redirect_to(:action => 'login')
  	end
  end

  def login
  	@user = User.new
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email)
  end
end
