class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = CartItem.all
  end

  def create
    # binding.pry
    @item = Item.find(cart_item_params[:item_id])
    @customer = current_customer
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.item_id = @item.id
    @cart_item.customer_id = @customer.id
    @cart_item.save
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount,:item_id)
  end
end
