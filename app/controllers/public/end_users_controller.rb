class Public::EndUsersController < ApplicationController
  def index
  end

  def show
    @end_user = EndUser.find(params[:id])

  end

  def edit
  end
end
