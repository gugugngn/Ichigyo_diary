Rails.application.routes.draw do


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # guest_sign_in用のルート
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

# 新規登録失敗時のリロードエラーを防ぐ
 get "users" => redirect("/users/sign_up")

 # Public側の記述
   root to: "public/homes#top"
   get 'homes/about', to: 'public/homes#about'

  scope module: :public do
    resources :users, only: [:edit, :show, :update, :destroy] do
      member do
        get :favorites
      end
      resources :messages, only: [:new, :index, :create, :destroy]
      collection do
        get :mypage
      end
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    get 'searches/search', to: 'searches#search'
  end

  # admin側の記述
  namespace :admin do
    resources :message_text, only: [:new, :create, :destroy]
    resources :moods, only: [:new, :create, :destroy]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:show, :destroy]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end