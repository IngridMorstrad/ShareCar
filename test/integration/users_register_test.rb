require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest

  test "signup with invalid information" do
    get 'sign_up'
    assert_template 'users/new'
    post 'sign_up', user: { email: "", password: "" }
    assert_template 'users/new'
  end

end
