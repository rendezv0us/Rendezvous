require 'test_helper'

class ExploreControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get explore_home_url
    assert_response :success
  end

end
