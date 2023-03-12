Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }

  root 'home#index'
  get '/faq', to: 'faq#index'

  namespace :admin do
    root 'posts#index'
    resources :posts
    resources :tags
  end
end
