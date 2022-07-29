class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @end_users = EndUser.page(params[:page])
  end

  def destroy
    end_user = EndUser.find(params[:id])
    end_user.destroy
    redirect_to admin_end_users_path

  end

  def show
    @end_user = EndUser.find(params[:id])
    #複数の本＝会員の本全部
    @reviews = @end_user.reviews
  end

end
