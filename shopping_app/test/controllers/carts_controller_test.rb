require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should show cart" do
    get cart_url(1)
    assert_response :success
  end
end
