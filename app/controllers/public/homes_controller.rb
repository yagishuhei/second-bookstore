class Public::HomesController < ApplicationController
  def top
    @reviews = Review.page(params[:page])
    @categories = Category.page(params[:page])
  end

end
