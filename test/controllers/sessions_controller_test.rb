require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @user = users(:petr)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  #[INFO] This test is pointless as we're already testing valid and invalid login attempts in integration testing
  #test "should get create" do
  #  post :create, { email: @user.email, password: "mypassword" }
  #  assert_redirected_to log_in_path
  #end

  test "should get destroy" do
    cookies[:auth_token] = @user.auth_token
    get :destroy, :id => @user.id
    assert_redirected_to(controller: "main")
  end

end
