require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post users_path, params: { user: { name:  "Example user", email: "user@example.com", password: "password", password_confirmation: "password" } }
		end
    follow_redirect!
		assert_template 'users/show'
		assert is_logged_in?
	end
end
