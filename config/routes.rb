Rails.application.routes.draw do
  root 'auctions#index'
  devise_for :users
  resources :auctions, only: [:index] do
    resources :bids, only: [:index, :new, :create]
  end

  resources :makers, only: [] do
    resources :cars, only: :index
  end

  namespace :my do
    resources :auctions, except: [:show] do
      resources :bids, only: [:index, :edit, :update]
    end
  end
end
