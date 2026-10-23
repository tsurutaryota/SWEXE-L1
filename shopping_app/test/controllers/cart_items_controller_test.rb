require "test_helper"

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "should create cart item" do
    product = Product.create!(name: "テスト商品", price: 200)
    before_count = CartItem.count

    post cart_items_url, params: { product_id: product.id }

    assert_response :redirect
    assert_equal before_count + 1, CartItem.count

    item = CartItem.order(:id).last
    assert_equal product.id, item.product_id
    assert_equal 1, item.qty
  end
end
