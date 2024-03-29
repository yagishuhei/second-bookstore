Rails.application.routes.draw do

#管理者側
# URL /admin/sign_in...
#管理者側のコントローラーがどこに存在するかを指定
#新規登録、パスワード変更はしないためskip オプションで削除
#加えてapp/views/admin/shared/_links.html.erbの余分な記述を削除
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions',
  }

  #会員側
  # URL /end_users/sign_in...
  #会員側のコントローラーがどこに存在するかを指定
  devise_for :end_users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  devise_scope :end_user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  #URLはadminをつけて、ファイル構成も指定
  namespace :admin do
    #カテゴリー
    resources :categories, only: [:index, :create, :destroy,]
    #本
    resources :books, only: [:index, :show]
    #レビュー
    resources :reviews, only: [:index, :show, :destroy,]
    #ユーザー
    resources :end_users, only: [:index, :show, :destroy,]

  end

  #URLはそのまま、ファイル構成だけ指定のパス
  scope module: :public do

    get root to: 'homes#top'
    get 'searchs/search_result', to: 'searchs#search_result', as: 'search_result'
    #カテゴリー
    resources :categories, only: [:index, :show]
    #出品
    resources :sales
    #先にdestroy_allを置く
    delete 'cart_items/destroy_all', to: 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    #カート内商品
    resources :cart_items, only: [:index, :create, :destroy]
    #注文
    get 'orders/order_confirm', to: 'orders#order_404'
    post 'orders/order_confirm', to: 'orders#order_confirm', as: 'order_confirm'
    get 'orders/thanks', to: 'orders#thanks', as: 'thanks'
    resources :orders, only: [:index, :new, :create, :show, :update]

    #住所
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    get 'end_users/mypage', to: 'end_users#mypage', as: 'mypage'
    get 'end_users/unsubscribe', to: 'end_users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'end_users/withdraw', to: 'end_users#withdraw', as: 'withdraw_end_user'
    #ユーザー
    resources :end_users, only: [:index, :show, :edit, :update] do
      member do
        #フォローフォロワー
        get :follows, :followers
      end
      resource :relationships, only: [:create, :destroy]
    end
    #本
    resources :books, only: [:index, :destroy, :create, :show] do
      get 'rakuten_result', to: 'books#rakuten_result', as: 'rakuten_result'
    end
    #レビュー
    resources :reviews, only: [:index, :create, :show, :edit, :update, :destroy] do
      #イイね機能(会員1人につき1イイね)
      resource :favorites, only: [:create, :destroy]
      #コメント機能
      resources :review_comments, only: [:create, :destroy]
      ##下書き機能(下書きページのためurlがつかない)
      collection do
        get 'review_confirm', as: 'review_confirm'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
