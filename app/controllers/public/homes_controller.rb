class Public::HomesController < ApplicationController
  def top
    @reviews = Review.all
    @categories = Category.all
  end

end
