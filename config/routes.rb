Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  devise_scope :user do
    match '/session/user', to: 'devise/sessions#create', via: :post
  end
  resources :users do
    resources :homes do
      resources :lists do
        resources :items
      end
    end
  end
  resources :homes
  resources :lists do
    resources :items
  end
  resources :homes do
    resources :bridges
  end
  resources :bridges do
    resources :groups do
      resources :bulbs
    end
  end
  resources :groups do
    resources :scenes
  end
  resources :static
  root 'static#index'
  get '/logout', to: 'remove#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
