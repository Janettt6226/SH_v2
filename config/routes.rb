Rails.application.routes.draw do
  get 'games/show'
  get 'games/new'
  get 'games/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :games, only: %i[new create show]
end
