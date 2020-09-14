Rails.application.routes.draw do
  root 'pages#home'
  # Articles Routes
  resources :articles, only: %i[show index new create update edit destroy]
  # User Routes
  get 'signup', to: 'users#new'
  resources :users, only: %i[show index create update edit destroy]

  # Routes estaticas
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
