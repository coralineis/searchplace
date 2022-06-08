require "test_helper"

class Public::PlaceGenresControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_place_genres_show_url
    assert_response :success
  end
end
