require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest

  test "signup with invalid information" do
    get 'sign_up'
    assert_template 'users/new'
    post 'sign_up', user: { name: "", email: "", password: "", password_confirmation: "" }
    assert_template 'users/new'
    assert_not flash.empty?, "Error! Flash is empty."
  end

end
