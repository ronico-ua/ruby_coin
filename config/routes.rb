# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  scope '/(:locale)', locale: /uk|en/ do
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
    }

    root 'home#index'
    get '/search', to: 'home#search'
    get '/faq', to: 'faq#index'
    get '/post/:id', to: 'home#show', as: 'post'
    get 'set_locale', to: 'application#set_locale'

    namespace :management do
      root 'posts#index', as: 'root'
      get 'statistics/index', to: 'statistics#index', as: 'statistics'

      resources :posts do
        post 'translate', on: :collection
      end

      resources :tags
    end

    namespace :api do
      resources :tags, only: :index
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
