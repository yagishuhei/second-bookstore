class Public::ReviewsController < ApplicationController
 #ログインしているか確認、ログイン状態ではない場合ログインページに移動
 before_action :authenticate_end_user!
 before_action :ensure_correct_end_user, only: [:update, :edit, :destroy]


  def index
    @review =Review.new
    @reviews = current_end_user.reviews.published
    @reviews =  @reviews.page(params[:page])
    @categories = Category.page(params[:page])
    @favorite_ranking = Review.includes(:favorited_end_users).sort {|a,b| b.favorited_end_users.size <=> a.favorited_end_users.size }
    @favorite_ranking = Kaminari.paginate_array(@favorite_ranking).page(params[:page]).per(4)
  end

  def review_confirm
    @reviews = current_end_user.reviews.draft
    @reviews =  @reviews.page(params[:page])
    @categories = Category.page(params[:page])
    @favorite_ranking = Review.includes(:favorited_end_users).sort {|a,b| b.favorited_end_users.size <=> a.favorited_end_users.size }
    @favorite_ranking = Kaminari.paginate_array(@favorite_ranking).page(params[:page]).per(4)
  end

  def create
    @review = current_end_user.reviews.new(review_params)
    @review.book_id = params[:book_id]
    if @review.save
      redirect_to review_path(@review.id), notice: "レビューの登録が完了しました。"
    else
      @book = Book.find(params[:book_id])
      render 'public/books/show'
    end
  end

  def destroy
    review = current_end_user.reviews.find(params[:id])
    review.destroy
    redirect_to reviews_path, notice: "登録されたレビューの削除が完了しました。"
  end

  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
    @index = params[:index]
  end

  def edit
     @review =Review.find(params[:id])
  end

  def update
    @review = current_end_user.reviews.find(params[:id])
    @review.update!(review_params)
    redirect_to review_path(@review.id), notice: "登録されたレビューの編集が完了しました。"
  end

  private

  def review_params
    params.require(:review).permit(:blog, :heading, :score, :review_status)
  end

  def ensure_correct_end_user
    @review = Review.find(params[:id])
    @end_user = @review.end_user
    unless @end_user == current_end_user
      redirect_to root_path, alert: "他のユーザー情報を変更することはできません。"
    end
  end
end
