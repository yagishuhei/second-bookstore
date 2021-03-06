class Public::CategoriesController < ApplicationController
  def index
    @category = Category.new
    @categories = Category.page(params[:page])
  end

  def show
    @category = Category.find(params[:id])
    @books = @category.books
    @books = @books.page(params[:page])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
