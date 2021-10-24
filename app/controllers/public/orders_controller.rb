class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
  end

end
