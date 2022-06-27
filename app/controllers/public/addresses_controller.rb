class Public::AddressesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:update, :edit, :destroy]

  def index
    @address = Address.new
    @addresses = current_end_user.addresses
    @addresses = @addresses.page(params[:page])
  end

  def create
    #binding.pry
    @address = current_end_user.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: "住所の登録が完了しました。"
    else
      @addresses = current_end_user.addresses
      render :index
    end

  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path, notice: "登録住所の削除が完了しました。"
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path, notice: "住所の変更が完了しました。"
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  def ensure_correct_end_user
    @address = Address.find(params[:id])
    @end_user = @address.end_user
    unless @end_user == current_end_user
      redirect_to root_path, alert: "他のユーザー情報を変更することはできません。"
    end
  end

end