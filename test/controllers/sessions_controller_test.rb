require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_redirected_to log_in_path
  end

  test "should get create" do
    get :create
    assert_redirected_to log_in_path
  end

  test "should get destroy" do
    user=User.create(name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns",activated:true)
    cookies[:auth_token]=user.auth_token
    get :destroy, :id => user.id
    assert_redirected_to(controller: "main")
  end

end
