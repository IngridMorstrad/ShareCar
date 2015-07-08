class UserMailer < ActionMailer::Base
  default from: "no-reply@sharecar.com"

  def welcome_email(user)
  	@user = user
  	mail(to: @user.email, subject: 'Welcome to ShareCar :-)')
  end

  def password_reset(user)
  	@user = user
  	mail(to: @user.email, subject: 'Password Reset')
  end
end
