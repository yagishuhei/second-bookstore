class Public::AddressesController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @address = Address.new
    @addresses = current_end_user.addresses
  end

  def create
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
    redirect_to addresses_path
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
