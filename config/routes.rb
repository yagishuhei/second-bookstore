Rails.application.routes.draw do

  namespace :admin do
    get 'categories/index'
    get 'categories/edit'
  end
  namespace :public do

  end
#管理者側
# URL /admin/sign_in...
#管理者側のコントローラーがどこに存在するかを指定
#新規登録、パスワード変更はしないためskip オプションで削除
#加えてapp/views/admin/shared/_links.html.erbの余分な記述を削除
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #URLはadminをつけて、ファイル構成も指定
  namespace :admin do

    resources :categories, only: [:index, :create, :destroy, :show]
    # resources :sales
    # resources :order_details
    # resources :orders
    # resources :addresses
    resources :books, only: [:index, :show]
    resources :reviews
    resources :end_users

  end

  #会員側
  # URL /end_users/sign_in...
  #会員側のコントローラーがどこに存在するかを指定
  devise_for :end_users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  #URLはそのまま、ファイル構成だけ指定のパス
  scope module: :public do

    get root to: 'homes#top'
    resources :categories, only: [:index, :show,]
    resources :sales
    #先にdestroy_allを置く
    delete 'cart_items/destroy_all', to: 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    resources :cart_items, only: [:index, :create, :destroy]

    resources :order_details
    resources :orders
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    get 'end_users/mypage', to: 'end_users#mypage', as: 'mypage'
    patch 'end_users/withdrow', to: 'end_users#withdraw', as: 'withdraw_end_user'
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :books, only: [:index, :destroy, :create, :show] do
      get 'rakuten_result', to: 'books#rakuten_result', as: 'rakuten_result'
    end
    resources :reviews, only: [:index, :create, :show, :edit, :update, :destroy] do
      #会員1人につき1イイね
      resource :favorites, only: [:create, :destroy]
      resources :review_comments, only: [:create, :destroy]
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
