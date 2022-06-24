class Public::ReviewsController < ApplicationController
 #ログインしているか確認、ログイン状態ではない場合ログインページに移動
 before_action :authenticate_end_user!

  def index
    @review =Review.new
    @reviews = current_end_user.reviews.published
    @reviews =  @reviews.page(params[:page])
    @categories = Category.page(params[:page])
  end

  def review_confirm
    @reviews = current_end_user.reviews.draft
    @reviews =  @reviews.page(params[:page])
    @categories = Category.page(params[:page])
  end

  def create
    @review = current_end_user.reviews.new(review_params)
    @review.book_id = params[:book_id]
    if @review.save
      redirect_to review_path(@review.id), notice: "レビューを登録しました。"
    else
      @book = Book.find(params[:book_id])
      render 'public/books/show'
    end
  end

  def destroy
    review = current_end_user.reviews.find(params[:id])
    review.destroy
    redirect_to reviews_path
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
    redirect_to review_path(@review.id)
  end

  private
  def review_params
    params.require(:review).permit(:blog, :heading, :score, :review_status)
  end
end
