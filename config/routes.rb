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
  end


end
