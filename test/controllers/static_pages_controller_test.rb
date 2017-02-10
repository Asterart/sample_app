require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

	def setup
		@base_title = "Charging Points map"
	end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Stay plug-in - Home | #{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Stay plug-in - Help | #{@base_title}"
  end

  test "should get about" do
  	get about_path
  	assert_response :success
  	assert_select "title", "Stay plug-in - About us | #{@base_title}"
  end

end
