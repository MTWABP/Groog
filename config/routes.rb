Rails.application.routes.draw do
  root to: 'home#index'
  
  post 'ghpull', to: 'home#ghpull'
  
  mount Upmin::Engine => '/admin'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  
  resources :groups, id: :slug
end
