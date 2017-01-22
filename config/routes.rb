# frozen_string_literal: true
Rails.application.routes.draw do
  mount AwesomeTranslations::Engine => "/awesome_translations" if Rails.env.development?

  devise_for :users

  resources :dashboards, only: :index

  resources :profiles do
    resources :databases do
      resources :tables, except: :index do
        resources :columns, except: :index
        resources :foreign_keys, except: :index
        resources :indexes, except: :index
        resources :rows
      end

      resources :sql_executions, only: [:new, :create]
    end
  end

  root "dashboards#index"
end
