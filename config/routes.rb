Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'games#new'
  get 'games/:id/edit_players', to: 'games#edit_players', as: "edit_players"
  patch 'games/:id/update_players', to: 'games#update_players', as: "update_players"
  resources :games, only: %i[new create]
  resources :games, only: %i[show] do
    # patch :update_players, on: :collection
    resources :players, only: %i[index show new create]
    resources :rounds, only: %i[show new create update ]
  end

  get 'rounds/:id/edit_chancellor', to: 'rounds#edit_chancellor', as: "edit_chancellor"
  # patch 'rounds/:id/update_chancellor', to: 'rounds#update_chancellor', as: "update_chancellor"


  resources :laws, only: %i[index show edit update]
end
