Rails.application.routes.draw do
  get 'page/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  devise_scope :user do
    match '/session/user', to: 'devise/sessions#create', via: :post
  end
  resources :user_homes
  resources :widgets
  resources :homes
  resources :homes
  resources :users do
    resources :user_homes
  end
  resources :static
  root 'page#index'
  get '/logout', to: 'remove#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
