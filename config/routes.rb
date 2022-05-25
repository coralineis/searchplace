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

    root to: 'homes#top'
    get 'about' => 'homes#about'
    resource :users, only: [:edit, :update] do
      collection do
        get :likes
      end
    end
    get 'users/my_page' => 'users#show', as: 'my_page'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :plans do
      collection do
        post :confirm
        get :search
      end
      resource :likes, only: [:create, :destroy]
    end
    resources :places do
      collection do
          post :confirm
      end
      resource :likes, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
