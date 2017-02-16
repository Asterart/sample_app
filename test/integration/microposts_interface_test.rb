require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:piotr)
  end

  test "micropost interface" do
  	log_in_as(@user)
  	get root_path
  	assert_select 'div.pagination'
  	#invalid submission
  	assert_no_difference 'Micropost.count' do
  		post microposts_path, params: {micropost: {content: ""}}
  	end
  	assert_select 'div#error_explanation'
  	#valid submission
  	content = "some kind of content"
  	assert_difference 'Micropost.count', 1 do
  		post microposts_path, params: {micropost: {content: content}}
  	end
  	assert_redirected_to root_url
  	follow_redirect!
  	assert_match content, response.body
  	#delete post
  	assert_select 'a', text: 'delete'
  	first_micropost = @user.microposts.paginate(page: 1).first
  	assert_difference 'Micropost.count', -1 do
  		delete micropost_path(first_micropost)
  	end
  	#visit different user and check for delete links
  	get user_path(users(:lana))
  	assert_select 'a', text: 'delete', count: 0
  end
end