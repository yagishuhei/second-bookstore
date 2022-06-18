class Public::CategoriesController < ApplicationController
  def index
    @category = Category.new
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
