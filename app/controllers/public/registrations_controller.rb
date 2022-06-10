# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  #emailとpassword以外のデータを保存できるようにする。
  #会員登録前にconfigure_permittd_parametersメソッドを実行。
  before_action :configure_permited_parameters, if: :devise_controller?

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  #会員登録後のパス指定
  def after_sign_up_path_for(resource)
    public_books_path
  end
  #会員ログアウト後のパス指定
  def after_sign_out_path_for(resource)
    public_books_path
  end

  #publicのregistration内で使用するため
  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  #devise_parameter_sanitizer.permitメソッドで会員登録時、以下のデータ操作を許可。
  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number])
  end
end
