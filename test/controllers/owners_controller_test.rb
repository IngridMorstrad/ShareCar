require 'test_helper'

class OwnersControllerTest < ActionController::TestCase
  test "should get new" do
  	user=User.new(id:1,name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns")
    if user.save
      cookies[:auth_token]=user.auth_token
    else
      puts "WTF BRO"
    end
    get :new
    assert_response :success
  end

end
