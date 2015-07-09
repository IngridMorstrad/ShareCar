require 'test_helper'

class OwnersControllerTest < ActionController::TestCase

  def setup
    @user = users(:petr)
  end

  test "should get new" do
    cookies[:auth_token] = @user.auth_token
    get :new
    assert_response :success
  end

end
