Rails.application.routes.draw do
  # devise_for :users

  # Root
  root to: 'pages#home'

  # Sidekiq Web UI, only for admins.
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'


  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :items, only: [:index, :show]
    end
  end
end
