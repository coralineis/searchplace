Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    resources :place_genres, only: [:create, :index, :show, :edit, :destroy]
    resources :shop_genres, only: [:create, :show, :edit, :destroy]
  end

  scope module: :public do
    devise_for :users, skip: [:password], controllers: {
      registrations: 'public/registrations',
      sessions: 'public/sessions'
    }

    root to: 'homes#top'
    get 'about' => 'homes#about'
    resource :users, only: [:edit, :update]
    get 'users/my_page' => 'users#show', as: 'my_page'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :plans
    resources :places
    resources :shops
    resources :likes, only: []
    resources :reviews, only: []
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
