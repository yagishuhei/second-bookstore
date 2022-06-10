class Public::ReviewsController < ApplicationController
 #ログインしているか確認、ログイン状態ではない場合ログインページに移動
 before_action :authenticate_end_user!

  def index
    @reviews = current_end_user.reviews
  end

  def create

    @review = current_end_user.reviews.new(review_params)

    @review.save
    redirect_to public_review_path(@review)
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
  end

  private
  def review_params
    params.require(:review).permit(:blog, :heading, :category_id, :book_id, :score)
  end
end
