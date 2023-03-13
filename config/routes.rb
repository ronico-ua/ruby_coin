Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root 'home#index'
  get '/faq', to: 'faq#index'
  get '/post/:id', to: 'post#show', as: 'post'

  namespace :admin do
    root 'posts#index'
    resources :posts
    resources :tags
  end
end
