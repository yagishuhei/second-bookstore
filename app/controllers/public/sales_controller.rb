class Public::SalesController < ApplicationController
  def new
    @books = current_end_user.books
    @books = @books.page(params[:page])
    @sale = Sale.new
    @sales = current_end_user.sales
    @sales = @sales.page(params[:page])
  end

  def index
    @sales = Sale.page(params[:page])
  end

  def create
    @sale = current_end_user.sales.new(sale_params)
    @sale.book_id = params[:sale][:book_id]
    if @sale.save
      redirect_to request.referer, notice: "出品が完了しました。"
    else
      @books= current_end_user.books
      @books = @books.page(params[:page])
      @sales = current_end_user.sales
      @sales = @sales.page(params[:page])
      render :new
    end
  end

  def destroy
    sale = current_end_user.sales.find(params[:id])
    sale.destroy
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
    params.require(:sale).permit(:book_id, :sale_image, :introduction, :price, :status, :title)
  end

end
