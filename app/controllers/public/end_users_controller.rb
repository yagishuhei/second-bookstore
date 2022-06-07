class Public::EndUsersController < ApplicationController
  def index
    @end_user = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])

  end

  def edit
  end
end
