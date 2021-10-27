class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    # binding.pry
  end
end