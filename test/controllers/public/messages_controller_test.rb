require "test_helper"

class Public::MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_messages_new_url
    assert_response :success
  end

  test "should get index" do
    get public_messages_index_url
    assert_response :success
  end

  test "should get create" do
    get public_messages_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_messages_destroy_url
    assert_response :success
  end
end
