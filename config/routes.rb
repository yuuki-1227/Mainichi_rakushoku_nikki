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
      get "relationships/fllowers" => "relationships#followers"
      get "/unsubscribe" => "end_users#unsubscribe"
      patch "/withdraw" => "end_users#withdraw"
      # いいね
      resource :favorites, only:[:create, :destroy]
      # コメント
      resources :post_comments, only:[:create, :destroy]
      # 買い物
      resources :shoppings
      # 食材
      resources :foods, only:[:index, :show, :edit, :update, :destroy]
      delete "foods/destroy_all" => "foods#destroy_all"
    end

    # 投稿記事
    resources :posts
    # ジャンル
    resource :genres, only:[:index]
    # トップ
    root to: "homes#top"
    get "/about" => "homes#about"
  end
end
