Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: 'admin/sessions'
}

  devise_for :users, controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
root to: "user/posts#index"
get '/about' => 'user/homes#about'

  namespace :admin do
    resources :users, only:[:show, :index, :edit, :update]
    resources :tags, only:[:index, :edit, :update, :destroy]
    resources :posts, only:[:show, :destroy]
  end

  scope module: :user do
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :users, only:[:show, :edit, :update, :destroy] do
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :contacts, only: [:new, :create] do
      collection do
        post :confirm
        post :back
        get :thanks
      end
    end
    get 'searches' => 'searches#search'

  end
end
