require "test_helper"

class Admin::MoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_moods_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_moods_destroy_url
    assert_response :success
  end

  test "should get new" do
    get admin_moods_new_url
    assert_response :success
  end
end
