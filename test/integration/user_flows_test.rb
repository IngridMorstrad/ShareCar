require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:petr)
	end

	test "logout and go to login page" do
		get log_in_path
		assert_template "sessions/new"
		post log_in_path, {email: @user.email, password: "mypassword"}
		assert_redirected_to trips_path
		follow_redirect!
		assert_template "trips/index"
		delete log_out_path
		assert_redirected_to root_path, "Error! Not on root page after clicking logout"
		get log_in_path
		assert_template "sessions/new"
	end
end
