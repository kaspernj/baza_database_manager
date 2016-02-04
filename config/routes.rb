Rails.application.routes.draw do
  mount AwesomeTranslations::Engine => "/awesome_translations" if Rails.env.development?

  devise_for :users

  resources :dashboards, only: :index

  resources :profiles do
    resources :databases do
      resources :exports

      resources :tables do
        resources :columns
        resources :indexes
        resources :rows
      end
    end
  end

  resources :users

  root "dashboards#index"
end
