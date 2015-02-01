Rails.application.routes.draw do
  root to: 'home#index'

  post 'ghpull', to: 'home#ghpull'

  authenticate :user, lambda { |u| u.admin? } do
    mount Upmin::Engine => '/upmin'
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :groups, param: :slug, except: [:destroy] do
    member do
      get 'join', action: :join
      post 'join', action: :create_membership
    end
  end
end
