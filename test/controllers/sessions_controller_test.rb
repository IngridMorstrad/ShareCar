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

  test "should logout user" do
    cookies[:auth_token] = @user.auth_token
    delete :destroy
    assert_redirected_to root_path, "Error! Not on root page after logout."
  end

end
