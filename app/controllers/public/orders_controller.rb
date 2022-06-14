class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def create
    @order = current_end_user.orders.new(order_params)
    @order.save
    redirect_to order_path(@order)
  end
  def index
  
  end

  def show
  end

  def edit
  end
  
  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
