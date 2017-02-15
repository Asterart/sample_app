require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

	def setup
		@base_title = "Let's get to know each other"
    @basic_title = "MeetMe"
	end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@basic_title} - Home" + " | " + "#{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "#{@basic_title} - Help" + " | " + "#{@base_title}"
  end

  test "should get about" do
  	get about_path
  	assert_response :success
  	assert_select "title", "#{@basic_title} - About us" + " | " + "#{@base_title}"
  end

end
