# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  #ログイン情報が保存される前に既存のEmailで会員ステータス確認
  before_action :end_user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  #会員ログイン後のパス指定
  def after_sign_in_path_for(resource)
    mypage_path
  end
  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end



# 退会ステータスの確認メソッド
  def end_user_state
    #入力された情報からfind_byを使ってemailカラムからアカウントを1件取得
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@end_user
    #valid_password?メソッドでパスワードの一致確認、かつ、会員ステータスが有効かの確認
    if (@end_user.valid_password?(params[:end_user][:password])) && (@end_user.is_deleted == true)
      redirect_to new_end_user_registration_path
    end
  end
end
