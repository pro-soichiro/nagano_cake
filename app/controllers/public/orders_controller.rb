class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = CartItem.all
    @sum = 0
    @order = Order.new(order_params)
    case params[:order][:select_address]
    when '0' then
      # current_customerのお届け先
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    when '1' then
      # 登録済み住所
      # @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    when '2' then
      # 新しいお届け先
      # @order = Order.new(order_params)
    end
    # binding.pry
  end


  private

  def order_params
    params.require(:order).permit(:payment_method,
                                  :postal_code,
                                  :address,
                                  :name)
  end

end
