require "test_helper"

class AuthorStatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get author_stats_index_url
    assert_response :success
  end
end
