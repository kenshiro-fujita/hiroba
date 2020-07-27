Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'how_to_use', to: 'how_to_uses#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'

  resources :users, except: [:new] do
    member do
      get :followings
      get :followers
      get :likes
      get :importants
    end
  end

  resources :books, only: %i[show index new create] do
    resources :reviews
  end

  # 以下は中間テーブルにつきcreateとdestroyのみ。
  resources :recommendations, only: %i[create destroy]
  resources :favorites, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
end
