Rails.application.routes.draw do
  devise_for :users

  resources :profiles
  resources :users

  root "dashboards#index"
end
