class Public::SalesController < ApplicationController
  def new
    @books= current_end_user.books
    @sale = Sale.new
    @sales = current_end_user.sales
  end
  def index
    @sales = Sale.all
  end

  def create
    @sale = current_end_user.sales.new(sale_params)
    @sale.book_id = params[:book_id]
    @sale.save
    redirect_to request.referer
  end

  def show
    @sale = Sale.find(params[:id])
  end

  def edit
    @sale = Sale.find(params[:id])
    @book = Book.find(params[:id])
  end

  def update
    @sale = current_end_user.sales.find(params[:id])
    @sale.book_id = params[:book_id]
    @sale.update(sale_params)
    redirect_to sale_path(@sale)
  end

  private
  def sale_params
    params.require(:sale).permit(:sale_image, :introduction, :price, :is_active)
  end

end
