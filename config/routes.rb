Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 管理者
  devise_for :admin, :controllers => {
    :registrations => 'admin/registrations',
    :sessions => 'admin/sessions'
  }

  # 管理者側
  namespace :admin do
    resources :end_users, only:[:show, :edit, :update, :index] do
      # フォロー、フォロワー
      get "relationships/follows" => "relationships#follows"
      get "relationships/fllowers" => "relationships#followers"
    end
    # 投稿記事
    resources :posts, only:[:index, :show, :edit, :update]
    # ジャンル
    resources :genres, only:[:index, :create, :edit, :update, :destroy]
  end

  # エンドユーザー
  devise_for :end_users, :controllers => {
    :registrations => 'public/end_users/registrations',
    :sessions => 'public/end_users/sessions'
  }

  scope module: :public do
    resources :end_users, only: [:show, :edit, :update, :index] do
      # フォロー、フォロワー
      resource :relationships, only:[:create, :destroy]
      get "relationships/follows" => "relationships#follows"
      get "relationships/followers" => "relationships#followers"
      # フォローする
      post 'follow' => 'relationships#follow', as: 'follow'
      # フォロー外す
      post 'unfollow' => 'relationships#unfollow', as: 'unfollow'
      get "/unsubscribe" => "end_users#unsubscribe"
      patch "/withdraw" => "end_users#withdraw"
      # 買い物
      resources :shoppings
    end

    # 食材
    resources :foods, only:[:index, :show, :create, :edit, :update, :destroy]
    delete "foods/destroy_all" => "foods#destroy_all"
    # 投稿記事
    resources :posts do
      # コメント
      resources :post_comments, only:[:create, :destroy]
      # いいね
      resource :favorites, only:[:create, :destroy]
    end
    # ジャンル
    resource :genres, only:[:index]
    # トップ
    root to: "homes#top"
    get "/about" => "homes#about"

    get '/search' => 'search#search'
  end
end
