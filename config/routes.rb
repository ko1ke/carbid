Rails.application.routes.draw do
  root 'auctions#index'
  devise_for :users
  resources :auctions, only: [:index] do
    resources :bids, only: [:index, :new, :create]
  end

  namespace :my do
    resources :auctions
  end

end
