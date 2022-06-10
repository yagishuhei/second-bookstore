class Public::ReviewsController < ApplicationController
 #ログインしているか確認、ログイン状態ではない場合ログインページに移動
 before_action :authenticate_end_user!

  def index
    @reviews = current_end_user.reviews
  end

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    @review.end_user_id = current_end_user.id
    @review.book_id = @book.id
    @review.save
    redirect_to public_book_review_path(@book, @review)
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
  end

  private
  def review_params
    params.require(:review).permit(:blog, :heading, :category_id, :score)
  end
end
