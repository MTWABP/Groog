Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  devise_for :users
  root to: 'home#index'
end
