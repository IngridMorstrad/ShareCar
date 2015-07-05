require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    user=User.new(id:1,name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns")
    if user.save
      cookies[:auth_token]=user.auth_token
    else
      puts "WTF BRO"
    end
    get :destroy, :id => user.id
    assert_redirected_to(controller: "main")
  end

end
