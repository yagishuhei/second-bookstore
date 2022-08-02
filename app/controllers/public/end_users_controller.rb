class Public::EndUsersController < ApplicationController
  #ログインしているか確認、ログイン状態ではない場合ログインページに移動
  before_action :authenticate_end_user!
  #ゲストユーザーが修正できないようにする
  before_action :ensure_guest_user, only: [:edit, :unsubscribe]
  before_action :ensure_correct_end_user, only: [:edit, :update, :unsubscribe]

  def index
    @end_users = EndUser.page(params[:page])
    @categories = Category.page(params[:page])
    #いいね機能で多い順に表示
    @favorite_ranking = Review.left_joins(:favorites).group(:id).order('count(favorites.review_id) desc').page(params[:page]).per(4)

  end
  def mypage
    @end_user = current_end_user
    @following_end_users = @end_user.following_end_user
    @followers_end_users = @end_user.follower_end_user
  end

  def show
    @end_user = EndUser.find(params[:id])
    @reviews = @end_user.reviews
    @reviews = @reviews.page(params[:page])
    #フォローユーザー
    @following_end_users = @end_user.following_end_user
    #フォロワーユーザー
    @followers_end_users = @end_user.follower_end_user
  end

  def edit
    @end_user = current_end_user
  end

  #退会機能
  def withdraw
    end_user = current_end_user
    end_user.is_deleted = true
    #論理削除
    end_user.save
    #ログイン情報をリセット
    reset_session
    redirect_to root_path
  end

  def update
    @end_user = current_end_user.update(end_user_params)
    if @end_user
      redirect_to mypage_path, notice: "プロフィール内容の編集が完了しました。"
    else
      render :edit, alert: "イメージ画像の拡張子が間違ってます"
    end
  end

   #フォローユーザー
  def follows
    end_user = EndUser.find(params[:id])
    @end_users = end_user.following_end_user.all.reverse_order
    @end_users =  @end_users.page(params[:page])
  end

  #フォロワーユーザー
  def followers
    end_user = EndUser.find(params[:id])
    @end_users = end_user.follower_end_user.all.reverse_order
    @end_users =  @end_users.page(params[:page])
  end

  def unsubscribe
  end

  private

  def end_user_params
    params.require(:end_user).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :nickname,
      :introduction,
      :postal_code,
      :address,
      :telephone_number,
      :profile_image
      )
  end

  def ensure_guest_user
    @end_user = EndUser.find(params[:id])
    if @end_user.last_name == "ゲスト" && @end_user.first_name == "ユーザー"
      redirect_to root_path , alert: 'ゲストユーザーは遷移できません。'
    end
  end

  def ensure_correct_end_user
    @end_user = EndUser.find(params[:id])
    unless @end_user == current_end_user
      redirect_to root_path, alert: "他のユーザー情報を変更することはできません。"
    end
  end
end