Rails.application.routes.draw do
  resources :groups

  mount Upmin::Engine => '/admin'
  devise_for :users
  root to: 'home#index'
end
