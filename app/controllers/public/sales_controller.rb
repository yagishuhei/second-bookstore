class Public::SalesController < ApplicationController
  def index
    @books= current_end_user.books
    @sale = Sale.new
    @sales = Sale.all
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.save
    redirect_to request.referer
  end

  def show
    @sale = Sale.find(params[:id])
  end

  def edit
    @sale = Sale.find(params[:id])
  end

  private
  def sale_params
    params.require(:sale).permit(:book_id, :category_id, :introduction, :price, :is_active)
  end

end
