class Public::SearchsController < ApplicationController
  def search_result
    #部分一致でタイトル検索
    @records = Review.where('heading LIKE ?', "%#{params[:search]}%") if params[:search].present?
    @records = @records.page(params[:page])
  end

end