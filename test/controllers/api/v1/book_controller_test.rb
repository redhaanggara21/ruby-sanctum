require "test_helper"

class Api::V1::BookControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_book_index_url
    assert_response :success
  end
end
