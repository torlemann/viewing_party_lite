Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get "/register", to: "users#new", as: :register
  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout"

  resources :users, only: [:create]

  namespace :user do
    get "/discover", to: "movies#discover"
    get "/dashboard", to: "dashboard#show"
    resources :movies, only: [:index, :show] do
      resources :viewing_parties, only: [:new, :create]
    end
  end

end
