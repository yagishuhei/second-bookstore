Rails.application.routes.draw do

  namespace :admin do
    get 'reviews/index'
    get 'reviews/show'
  end
  namespace :admin do
    get 'end_users/index'
    get 'end_users/show'
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
#加えてapp/views/admin/shared/_links.html.erbの余分な記述を削除
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #URLはそのまま、ファイル構成だけ指定のパス
  scope module: :public do
     get root to: 'homes#top'
  end

#URLはpublicをつけて、ファイル構成も指定
  namespace :public do

    resources :categories
    resources :items


    resources :order_details
    resources :orders
    resources :addresses
    resources :books, only: [:index, :create, :show] do
      get 'rakuten_result', to: "books#rakuten_result", as: "rakuten_result"
    end
    resources :reviews

    resources :end_users

  end

#URLはadminをつけて、ファイル構成も指定
   namespace :admin do

    resources :categories
    # resources :items
    # resources :order_details
    # resources :orders
    # resources :addresses
    resources :books, only: [:index, :show]
    resources :reviews
    resources :end_users

  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
