Rails.application.routes.draw do

  root to: 'home#index'

  post 'ghpull', to: 'home#ghpull'
  get 'user/:id', to: 'home#profile', as: :user
  post 'pusher/auth', to: 'home#pusher_auth'

  authenticate :user, lambda { |u| u.admin? } do
    mount Upmin::Engine => '/upmin'
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }


  resources :groups, param: :slug, except: [:destroy] do
    resources :tasks do
      member do
        post 'comment', action: :create_comment
      end
    end
	  resources :messages

    collection do
      get 'activate/:id', action: :activate_invitation
    end
    member do
      post 'invite', action: :invite
      get 'join', action: :join
      post 'join', action: :create_membership
      post 'join/:user_id', action: :activate_membership, as: :activate_user
    end
  end
end
