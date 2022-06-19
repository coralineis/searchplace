Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    resources :place_genres
    resources :users, only:[:show, :index, :edit, :update]
  end

  scope module: :public do
    devise_for :users, controllers: {
      registrations: 'public/registrations',
      sessions: 'public/sessions'
    }

    root to: 'places#index'
    get 'places/search'
    get 'about' => 'homes#about'
    resources :users, only: [:show, :edit, :update] do
      collection do
        get :likes
      end
    end
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :places do
      resource :likes, only: [:create, :destroy]
      collection do
          post :confirm
          get 'search'
      end
    end
    resources :place_genres, only: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
