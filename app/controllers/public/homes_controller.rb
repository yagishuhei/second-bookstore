class Public::HomesController < ApplicationController
  def top
    @reviews = Review.published.order(id: :DESC)
    @reviews = @reviews.page(params[:page])
    @categories = Category.page(params[:page])
    @favorite_ranking = Review.left_joins(:favorites).group(:id).order('count(favorites.review_id) desc').page(params[:page]).per(4)
  end

end
