Rails.application.routes.draw do
  root to: 'home#index'
  mount Upmin::Engine => '/admin'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  
  resources :groups
end
