class Public::OrderDetailsController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order_detail = @order.order_details.find(params[id])
    @order_detail.update(order_detail_params)
    redirect_to "public/orders/show"
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:shipping_status)
  end
end
