Rails.application.routes.draw do
  root "home_page#home"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/history", to: "histories#index"

  resources :tours, only: %i(index show)
  resources :users, only: :show
  resources :categories, only: :show
  resources :reviews, only: :create
  resources :ratings, only: %i(create update)
  resources :bookings, only: %i(new create)

  namespace :admin do
    root "dashboard#index"
    resources :bookings, only: %i(index show update)
    resources :categories, except: %i(new edit update)
    resources :tours do
      resources :description_details, except: %i(index show)
    end
  end
end
