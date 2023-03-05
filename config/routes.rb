Rails.application.routes.draw do
  devise_for :users

  root 'home#index'
  get '/faq', to: 'faq#index'

  namespace :admin do
    root 'posts#index'
    resources :posts
    resources :tags
  end
end
