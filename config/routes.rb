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
    resources :tags, only:[:index]
  end

  # エンドユーザー
  devise_for :end_users, :controllers => {
    :registrations => 'public/end_users/registrations',
    :sessions => 'public/end_users/sessions'
  }

  scope module: :public do
    get "/end_users/follower_ranking" => "end_users#follower_ranking"
    get "/end_users/post_ranking" => "end_users#post_ranking"
    resources :end_users, only: [:show, :edit, :update, :index] do
      # フォロー、フォロワー
      resource :relationships, only:[:create, :destroy]
      get "relationships/follows" => "relationships#following_end_users"
      get "relationships/followers" => "relationships#follower_end_users"
      # フォローする
      post 'follow' => 'relationships#follow', as: 'follow'
      # フォロー外す
      post 'unfollow' => 'relationships#unfollow', as: 'unfollow'
      get "/unsubscribe" => "end_users#unsubscribe"
      patch "/withdraw" => "end_users#withdraw"
      # 買い物
      resources :shoppings do
        # 食材
        resources :foods, only:[:create, :edit, :update, :destroy]
        delete "foods/destroy_all" => "foods#destroy_all"
      end
    end

    # 投稿記事いいね数ランキング
    get "/posts/favorited_ranking" => "posts#favorited_ranking"
     # 投稿記事コメント数ランキング
    get "/posts/commented_ranking" => "posts#commented_ranking"
    # 投稿記事
    resources :posts do
      # コメント
      resources :post_comments, only:[:create, :destroy]
      # いいね
      resource :favorites, only:[:create, :destroy]
    end
     # タグ絞り込み投稿の表示
    resources :tags do
      get 'posts' => 'posts#search'
    end
    # トップ
    root to: "homes#top"
    get "/about" => "homes#about"
    # タグ一覧
    get '/search' => 'search#search'
    # お問い合わせ関連
    post 'contacts/confirm' => 'contacts#confirm'
    post 'contacts/back' => 'contacts#back'
    get 'done' => 'contacts#done'
    resources :contacts, only:[:new, :create]
  end
end
