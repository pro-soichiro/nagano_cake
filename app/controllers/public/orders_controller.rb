class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = CartItem.all
    @sum = 0
    @total_payment = 0
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

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    @cart_items = CartItem.all
    @order_detail = OrderDetail.new
    @order_detail.order_id = @order.id

    @cart_items.each do |cart_item|
      @order_detail.item_id = cart_item.item_id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
    end
    @order_detail.save
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end

  def index
    @orders = Order.all
  end

  def show

  end


  private

  def order_params
    params.require(:order).permit(:payment_method,
                                  :postal_code,
                                  :address,
                                  :name,
                                  :total_payment)
  end

end
