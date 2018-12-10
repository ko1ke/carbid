Rails.application.routes.draw do
  root 'auctions#index'
  devise_for :users
  namespace :my do
    resources :auctions
  end

end
