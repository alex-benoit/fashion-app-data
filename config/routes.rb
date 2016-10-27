Rails.application.routes.draw do
  # devise_for :users

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :items, only: [:index, :show]
    end
  end
end
