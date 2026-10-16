Rails.application.routes.draw do
  root "tweets#index"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users, only: [:index, :new, :create, :destroy]
  resources :tweets, only: [:index, :new, :create, :destroy] do
    resources :likes, only: [:create, :destroy]
  end

  get "profile", to: "profiles#show", as: :profile
  get "profile/edit", to: "profiles#edit", as: :edit_profile
  patch "profile", to: "profiles#update"
end
