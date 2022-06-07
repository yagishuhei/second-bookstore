Rails.application.routes.draw do

  namespace :public do
    get 'categories/index'
    get 'categories/show'
    get 'categories/edit'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
    get 'items/edit'
  end
  namespace :public do
    get 'order_details/index'
    get 'order_details/edit'
    get 'order_details/show'
  end
  namespace :public do
    get 'orders/index'
    get 'orders/show'
    get 'orders/edit'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/show'
    get 'addresses/edit'
  end
  namespace :public do
    get 'books/index'
    get 'books/show'
  end
  namespace :public do
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/edit'
  end
  namespace :public do
    get 'end_users/index'
    get 'end_users/show'
    get 'end_users/edit'
  end
  namespace :public do
    get 'homes/top'
  end
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
