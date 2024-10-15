require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_posts_destroy_url
    assert_response :success
  end
end
