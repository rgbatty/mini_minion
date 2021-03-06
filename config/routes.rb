require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  match '*all', to: "application#preflight", via: [:options]

  get 'request_token', to: "token#request_token"
  get 'access_token', to: "token#access_token"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :status, only: [:index]
      resources :minion, only: [:index, :create]

      get 'current_user', to: "current_user#index"

      get 'minion/update', to: "minion/update#index"
      get 'minion/feed', to: "minion/feed#index"
    end
  end
end
