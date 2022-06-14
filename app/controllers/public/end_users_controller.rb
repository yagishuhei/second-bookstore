class Public::EndUsersController < ApplicationController
  #ログインしているか確認、ログイン状態ではない場合ログインページに移動
  before_action :authenticate_end_user!

  def index
    @end_users = EndUser.all

  end
  def mypage
    @end_user = current_end_user
  end

  def show
    @end_user = EndUser.find(params[:id])
    #複数の本＝会員の本全部
    @reviews = @end_user.reviews
    @sales = @end_user.sales
  end


  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = EndUser.find(params[:id])
    @end_user.update(end_user_params)
    redirect_to end_user_path(@end_user)
  end
  private

  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :introduction, :postal_code, :address, :telephone_number, :profile_image)
  end

end