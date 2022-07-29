class Public::ReviewCommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review_comment = current_end_user.review_comments.new(review_comment_params)
    @review_comment.review_id = @review.id
    @review_comment.save
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review_comment = ReviewComment.find(params[:id])
    @review_comment.destroy
  end


  private
  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end

end