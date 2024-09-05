Rails.application.routes.draw do
 
 
  namespace :public do
    get 'messages/new'
    get 'messages/index'
    get 'resources/create'
    get 'messages/destroy'
  end
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
  
 # Public側の記述
   root to: "public/homes#top"

  scope module: :public do
     resources :users, only: [:mypage, :edit, :show, :update, :destroy] do
       member do
          get :mypage
       end
     end
     resources :posts
     resources :messages, only: [:new, :index, :create, :destroy]
  end
  

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
