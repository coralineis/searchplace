Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    resources :place_genres, except: [:new, :show]
    resources :users, only: [:show, :index]
  end

  scope module: :public do
    devise_for :users, controllers: {
      registrations: 'public/registrations',
      sessions: 'public/sessions'
    }

    devise_scope :users do
      get "sign_in", :to => "users/sessions#new"
      get "sign_out", :to => "users/sessions#destroy"
      post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    end

    root to: 'places#index'
    get 'places/search'
    get 'about' => 'homes#about'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :users, only: [:show, :edit, :update] do
      collection do
        get :likes
      end
    end
    resources :places do
      resource :likes, only: [:create, :destroy]
      collection do
        get 'like_rank'
      end
    end
    post 'places/confirm' => 'places#confirm', as: 'confirm'
    resources :place_genres, only: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
