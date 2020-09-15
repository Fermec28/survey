Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/health", to: "health#health"
  namespace :api do
    namespace :v1 do
      post "/login", to: "auth#login"
      get "/is_authenticated", to: "auth#user_is_authenticated"
    end
  end
  namespace :api do
    namespace :v1 do
      resource :users, only: [:create]
      resources :surveys, only: [:index, :create, :update, :show, :destroy]
    end
  end
end
