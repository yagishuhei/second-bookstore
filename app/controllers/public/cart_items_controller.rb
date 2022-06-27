class Public::CartItemsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:destroy_all, :destroy]

  def create
    @update_cart_item = current_end_user.cart_items.new(cart_item_params)
    #find_byでカート内に同じものがあるか確認
    @cart_item = CartItem.find_by(sale_id: @update_cart_item.sale_id, end_user_id: current_end_user.id)
      #カート商品に同じものがないとき
      unless @cart_item.present?
        @update_cart_item.save
        redirect_to cart_items_path, notice: "カート商品として追加しました"
      else
      #カート商品に同一のものがあるとき
      @cart_items = CartItem.all
      flash[:alert] = "カート商品として既に存在しています。"
       render "index"

      end
  end

  def destroy_all
    #ログインしている会員のカート商品全て
    @cart_items = current_end_user.cart_items
    #ログインしている会員のカート商品全て削除
    @cart_items.destroy_all
    redirect_to cart_items_path, notice: "カート商品の全ての削除が完了しました"
  end


  def index
    @cart_items = current_end_user.cart_items

  end


  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path, notice: "カート商品の削除が完了しました"
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:sale_id)
  end

  def ensure_correct_end_user
    @cart_item = CartItem.find(params[:id])
    @end_user = @cart_item.end_user
    unless @end_user == current_end_user
      redirect_to root_path, alert: "他のユーザー情報を変更することはできません。"
    end
  end
end
