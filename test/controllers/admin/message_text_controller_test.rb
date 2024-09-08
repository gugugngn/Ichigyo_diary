require "test_helper"

class Admin::MessageTextControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_message_text_new_url
    assert_response :success
  end
end
