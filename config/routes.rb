Rails.application.routes.draw do
  get 'option/create'
  get 'option/destroy'
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
      resources :surveys, only: [:index, :create, :update, :show, :destroy] do
        resources :questions, only: [:create, :update, :destroy]
      end

      resources :questions, only: [] do
        resources :options, only: [:index, :create, :update, :show, :destroy] 
      end
    end
  end
end
