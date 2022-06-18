
class Public::OrdersController < ApplicationController
  def index

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
      @order_details.save
    end

    @cart_items.destroy_all
    redirect_to thanks_path
  end

  def order_confirm
    @order = current_end_user.orders.new(order_params)
    @cart_items = current_end_user.cart_items
    @order.shipping_cost = 800
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




  def show
    @order = Order.find(params[:id])
    @cart_items = CartItem.all
  end

  def edit
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :shipping_address, :shipping_name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
