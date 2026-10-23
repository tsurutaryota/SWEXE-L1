class CartItemsController < ApplicationController
  before_action :current_cart

  def new
    @cart_item = CartItem.new
  end

  def create
    product = Product.find(params[:product_id])
    cart_item = current_cart.cart_items.find_by(product_id: product.id)

    if cart_item
      cart_item.update!(qty: cart_item.qty + 1)
    else
      current_cart.cart_items.create!(product: product, qty: 1)
    end

    redirect_to products_path, notice: "カートに商品を追加しました。"
  end

  def destroy
    cart_item = current_cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path(current_cart), notice: "カートから商品を削除しました。"
  end
end
