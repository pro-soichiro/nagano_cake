class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = CartItem.all
    @sum = 0
  end

  def create
    @item = Item.find(cart_item_params[:item_id])

    @cart_item = CartItem.new(cart_item_params)


    if CartItem.find_by(item_id: @item.id)
      @original_cart_item = CartItem.find_by(item_id: @item.id)
      @original_cart_item.amount += @cart_item.amount.to_i

      @original_cart_item.save
      redirect_to cart_items_path
    else
      @cart_item.item_id = @item.id
      @cart_item.customer_id = current_customer.id
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end


  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount,:item_id)
  end
end