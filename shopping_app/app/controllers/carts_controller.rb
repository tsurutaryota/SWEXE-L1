class CartsController < ApplicationController
  def show
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(:product)
    @total_price = @cart_items.sum { |item| item.product.price * item.qty }
  end
end
