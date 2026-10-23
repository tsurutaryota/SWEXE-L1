class ApplicationController < ActionController::Base
  helper_method :current_cart

  private

  def current_cart
    cart = Cart.find_by(id: session[:cart_id])

    unless cart
      cart = Cart.create!
      session[:cart_id] = cart.id
    end

    cart
  end
end
