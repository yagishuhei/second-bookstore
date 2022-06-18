class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to root_path,notice: 'ゲストユーザーでログインしました。'
  end

end

