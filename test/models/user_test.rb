require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com",
  									password: "foobar", password_confirmation: "foobar" )
  end

 	test "password should be present (nonblank)" do
 		@user.password = @user.password_confirmation = "  " *6
 		assert_not @user.valid?
 	end

 	test "password should have a minimum length" do
 		@user.password = @user.password_confirmation = "a" * 5
 		assert_not @user.valid?
 	end

  test "name should be valid" do
  	@user.name = "     "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end

  test "email should be valid" do
  	@user.email = "     "
  	assert_not @user.valid?
  end

  test "email addresses should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

end