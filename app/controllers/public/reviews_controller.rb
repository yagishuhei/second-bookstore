class Public::ReviewsController < ApplicationController
 #ログインしているか確認、ログイン状態ではない場合ログインページに移動
  before_action :authenticate_end_user!

  def index
    @review = Review.all
  end

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    @review.end_user_id = current_end_user.id
    @review.book_id = @book.id
    @review.save
    redirect_to public_books_path
  end

  def show
  end

  def edit
  end

  private
  def review_params
    params.require(:review).permit(:blog,)
  end
end
