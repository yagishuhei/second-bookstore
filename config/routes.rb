Rails.application.routes.draw do

#会員側
# URL /end_users/sign_in...
#会員側のコントローラーがどこに存在するかを指定
  devise_for :end_users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }


#管理者側
# URL /admin/sign_in...
#管理者側のコントローラーがどこに存在するかを指定
#新規登録、パスワード変更はしないためskip オプションで削除
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
