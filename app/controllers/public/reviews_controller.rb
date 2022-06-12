class Public::ReviewsController < ApplicationController
 #ログインしているか確認、ログイン状態ではない場合ログインページに移動
 before_action :authenticate_end_user!

  def index
    @reviews = current_end_user.reviews
  end

  def create
    @review = current_end_user.reviews.new(review_params)
    @review.book_id = params[:book_id]
    @review.save
    redirect_to public_review_path(@review.id)
  end

  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
  end

  def edit
     @review =Review.find(params[:id])
     @book = Book.find(params[:id])
  end

  def update
    @review = current_end_user.reviews.find(params[:id])
    @review.book_id = params[:book_id]
    @review.update(review_params)
    redirect_to public_review_path(@review.id)
  end

  private
  def review_params
    params.require(:review).permit(:blog, :heading, :score)
  end
end
