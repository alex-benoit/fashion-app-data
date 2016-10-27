Rails.application.routes.draw do
  # devise_for :users

  # Root
  root to: 'pages#home'

  # Sidekiq Web UI, only for admins.
  # require 'sidekiq/web'
  # authenticate :user, lambda { |u| u.admin } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :items, only: [:index, :show]
    end
  end
end
