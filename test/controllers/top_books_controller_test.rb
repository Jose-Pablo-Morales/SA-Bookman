require "test_helper"

class TopBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get top_books_index_url
    assert_response :success
  end
end
