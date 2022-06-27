class Public::HomesController < ApplicationController
  def top
    @reviews = Review.order(id: :DESC)
    @reviews = @reviews.page(params[:page])
    @categories = Category.page(params[:page])
    @favorite_ranking = Review.includes(:favorited_end_users).sort {|a,b| b.favorited_end_users.size <=> a.favorited_end_users.size }
    @favorite_ranking = Kaminari.paginate_array(@favorite_ranking).page(params[:page]).per(4)
  end

end
