class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = CartItem.all
    @sum = 0
  end

  def create
    # itemの情報を受け取っている
    @item = Item.find(cart_item_params[:item_id])

    # フォーム画面で入力された値を受け取っている
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
