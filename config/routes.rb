Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth', registrations: 'users/registrations' }
  devise_scope :user do
    match '/session/user', to: 'devise/sessions#create', via: :post
    match '/users/sign_up', to: 'devise/registrations#create', via: :post
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
      resources :scenes
    end
  end
  resources :groups do
    resources :scenes
  end
  resources :scenes
  resources :users do
    resources :homes do
      resources :pets
    end
  end
  resources :pets
  resources :static
  get '/logout', to: 'remove#destroy'
  root 'static#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
