class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = CartItem.all
    @sum = 0
  end

  def create
    @item = Item.find(cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)

    if Item.find_by(name: @item.name)
      # puts "商品が存在する"
      @.amount += @item.amount.to_i

      @cart_item.update
      redirect_to cart_items_path
    else
      # puts "商品が存在しない"
      @cart_item.item_id = @item.id
      @cart_item.customer_id = current_customer.id
      @cart_item.save
      redirect_to cart_items_path
    end
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
