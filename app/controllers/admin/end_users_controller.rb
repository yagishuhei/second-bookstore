class Admin::EndUsersController < ApplicationController
  def index
    @end_users = EndUser.all
  end

  def destroy
    end_user = EndUser.find(params[:id])
    end_user.destroy
    redirect_to request.referer

  end

  def show
    @end_user = EndUser.find(params[:id])
    #複数の本＝会員の本全部
    @reviews = @end_user.reviews
  end
end
