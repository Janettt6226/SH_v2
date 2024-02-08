Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'games#new'
  resources :games, only: %i[new create show] do
    resources :players, only: %i[index show new create]
  end
  
end
