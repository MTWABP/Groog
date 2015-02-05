Rails.application.routes.draw do
  root to: 'home#index'

  post 'ghpull', to: 'home#ghpull'
  get 'user/:id', to: 'home#profile', as: :user

  authenticate :user, lambda { |u| u.admin? } do
    mount Upmin::Engine => '/upmin'
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }


  resources :groups, param: :slug, except: [:destroy] do
    member do
      get 'join', action: :join
      post 'join', action: :create_membership
      post 'join/:user_id', action: :activate_membership, as: :activate_user
    end
  end
end
