class Public::SalesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:update, :edit, :destroy]


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
      redirect_to sale_path(@sale), notice: "出品が完了しました。"
    else
      @books= current_end_user.books
      @books = @books.page(params[:page])
      @sales = current_end_user.sales
      @sales = @sales.page(params[:page])
      render :new, alert: "編集内容を保存できませんでした。"
    end
  end

  def destroy
    sale = current_end_user.sales.find(params[:id])
    sale.destroy
    redirect_to new_sale_path, notice: "出品内容の削除が完了しました。"
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
    if @sale.update!(sale_params)
      redirect_to sale_path(@sale), notice: "出品内容の編集が完了しました。"
    else
      render :edit, alert: "編集内容を保存できませんでした。"
    end
  end

  private

  def sale_params
    params.require(:sale).permit(
      :book_id,
      :sale_image,
      :introduction,
      :price,
      :status,
      :title
      )
  end

  def ensure_correct_end_user
    @sale = Sale.find(params[:id])
    @end_user = @sale.end_user
    unless @end_user == current_end_user
      redirect_to root_path, alert: "他のユーザー情報を変更することはできません。"
    end
  end

end
