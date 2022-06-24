class Public::SearchsController < ApplicationController
  def search_result
    @records = Book.where('title LIKE ?', "%#{params[:search]}") if params[:search].present?
    @records = @records.page(params[:page])
  end

end