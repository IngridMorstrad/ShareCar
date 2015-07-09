require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
  	@user = users(:petr)
  end

  test "login with invalid information" do
    get log_in_path
    assert_template 'sessions/new'
    post log_in_path, { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?, "Error! Flash is not empty upon going to root_path!"
  end

  test "login with valid information" do
    get log_in_path
    post log_in_path, { email: @user.email, password: 'mypassword' }
    assert_redirected_to trips_path, "Error! Was not redirected to trips/index."
    follow_redirect!
    assert_template 'trips/index'
  end

end
