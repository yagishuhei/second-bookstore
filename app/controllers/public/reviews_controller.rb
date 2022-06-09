class Public::ReviewsController < ApplicationController
  def index
  end

  def create
    @book = Book.find(params[:book_id])
    @review = current_end_user.reviews.new(review_params)
    @review.book_id = @book.id
    review.save
    redirect_to public_books_path
  end

  def show
  end

  def edit
  end

  private
  def review_params
    params.require(:review).permit(:blog)
  end
end
