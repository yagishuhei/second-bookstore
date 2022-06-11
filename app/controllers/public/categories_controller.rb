class Public::CategoriesController < ApplicationController
  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    @category.save

    redirect_to public_categories_path
  end

  def edit
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
