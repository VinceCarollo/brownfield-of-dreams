# frozen_string_literal: true

Rails.application.routes.draw do
  get '/auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'users#update'

  get '/invite', to: 'invites#new'
  post '/invite', to: 'invites#create'

  patch '/friends/:github_username', to: 'friends#update', as: 'friend'

  namespace :api do
    namespace :v1 do
      resources :tutorials, only: %i[show index]
      resources :videos, only: [:show]
    end
  end

  root 'welcome#index'
  get '/welcome', to: 'welcome#show'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :tutorials, only: %i[create edit update destroy new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:destroy]

    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: %i[new create update edit] do
    member do
      get :confirm_email
    end
  end

  resources :tutorials, only: %i[show index] do
    resources :videos, only: %i[show index]
  end

  resources :user_videos, only: %i[create destroy]

  match '*path', to: 'application#four_oh_four', via: :all
end
