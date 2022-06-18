class Public::EndUsersController < ApplicationController
  #ログインしているか確認、ログイン状態ではない場合ログインページに移動
  before_action :authenticate_end_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @end_users = EndUser.all


  end
  def mypage
    @end_user = current_end_user
    @following_end_users = @end_user.following_end_user
    @followers_end_users = @end_user.follower_end_user
  end

  def show
    @end_user = EndUser.find(params[:id])
    #複数の本＝会員の本全部
    @review = @end_user.reviews.last
    @sales = @end_user.sales
    @following_end_users = @end_user.following_end_user
    @followers_end_users = @end_user.follower_end_user
  end




  def edit
    @end_user = current_end_user
  end

  def withdraw
    end_user = current_end_user
    end_user.is_deleted = true
    end_user.save
    #ログイン情報をリセット
    reset_session
    redirect_to root_path
  end

  def update
    @end_user = EndUser.find(params[:id])
    @end_user.update(end_user_params)
    redirect_to end_user_path(@end_user)
  end

  def follows
    end_user = EndUser.find(params[:id])
    @end_users = end_user.following_end_user.all.reverse_order
  end

  def followers
    end_user = EndUser.find(params[:id])
    @end_users = end_user.follower_end_user.all.reverse_order
  end

  private

  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :introduction, :postal_code, :address, :telephone_number, :profile_image)
  end

  def ensure_guest_user
    @end_user = EndUser.find(params[:id])
    if @end_user.last_name == "ゲスト" && @end_user.first_name == "ユーザー"
      redirect_to root_path , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end