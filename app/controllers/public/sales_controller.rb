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
    #エラーが発生
    #ActiveRecord::RecordInvalid in Public::SalesController#create
    #Validation failed: Book must exist

    @sale = current_end_user.sales.new(sale_params)
    @sale.book_id = params[:sale][:book_id]
    @sale.save
    redirect_to request.referer
  end

  def show
    @sale = Sale.find(params[:id])
    @cart_item = CartItem.new
  end

  def edit
    @sale = Sale.find(params[:id])
  end

  def update
   
    @sale = current_end_user.sales.find(params[:id])
    @sale.update!(sale_params)
    redirect_to sale_path(@sale)
  end

  private
  def sale_params
    params.require(:sale).permit(:book_id, :sale_image, :introduction, :price, :is_active)
  end

end
