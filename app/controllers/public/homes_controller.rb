class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.limit(4).order(created_at: :desc)
  end
end
