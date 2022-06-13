class Public::AddressesController < ApplicationController
  def index
    @addresses = current_end_user.addresses
  end

  def create
    @address = current_end_user.addresses.new(address_params)
    @address.save
    redirect_to addresses_path
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
    params.require(:address).permit(:name)
  end
