
class Public::OrdersController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @orders = current_end_user.orders
    @orders = @orders.page(params[:page])
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_end_user.orders.new(order_params)
    @order.save

      @cart_items = current_end_user.cart_items
      #cart_itemの情報を渡す
      @cart_items.each do |cart_item|
      #カラ箱を用意する
        @order_details = OrderDetail.new
        @order_details.order_id = @order.id
        @order_details.sale_id = cart_item.sale.id
        @order_details.price = cart_item.sale.price
        @order_details.save
        # 買ったら一覧から消したい
        @update_sale = cart_item.sale
        @update_sale.update(status: "buying")
      end


      @cart_items.destroy_all
      redirect_to thanks_path
  end
  
  #注文情報入力
  def order_confirm
    @order = current_end_user.orders.new(order_params)
    @cart_items = current_end_user.cart_items
    #住所の場合分け
    if params[:order][:address] == "1"
      @order.postal_code = current_end_user.postal_code
      @order.shipping_address = current_end_user.address
      @order.shipping_name = current_end_user.last_name + current_end_user.first_name
    elsif params[:order][:address] =="2"

      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.shipping_address = @address.address
      @order.shipping_name = @address.name
    end
  end
  
  #order_confirmでリロード時のエラー対応
  def order_404
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.new
    @cart_items = CartItem.all
  end

  def update
    @order = current_end_user.orders.find(params[:id])
    @order.update!(order_params)
    redirect_to order_path(@order), notice: "注文ステータスの変更が完了しました。"
  end

  private

  def order_params
    params.require(:order).permit(
      :postal_code,
      :shipping_address,
      :shipping_name,
      :shipping_cost,
      :total_payment,
      :payment_method,
      :status
      )
  end

  def sale_params
    params.require(:sale).permit(:status)
  end
end
