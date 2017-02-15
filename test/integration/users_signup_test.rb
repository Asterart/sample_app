require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "", email: "user@example", password: "foo", password_confirmation: "password" } }
    end
    assert_template 'users/new'
    #assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end


  test "valid signup information" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post users_path, params: { user: { name:  "Example user", email: "user@example.com", password: "password", password_confirmation: "password" } }
		end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # login before activatio
    log_in_as(user)
    assert_not is_logged_in?
    #invalid activation token
    get edit_account_activation_path('invalid token', email: user.email)
    assert_not is_logged_in?
    #valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: "wrond")
    assert_not is_logged_in?
    #valid all
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
		assert_template 'users/show'
		assert is_logged_in?
	end
end
