Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/acceso', to: 'users#new'
  post '/acceso', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :categorias
  resources :equipos
  resources :players
  get '/eventos/calendario' => 'eventos#calendario', as: 'calendario'
  resources :eventos
  get '/equipos/:id/eventos_feed' => 'equipos#eventos_feed', as: 'eventosFeed'
  get '/eventos/:id/players_feed' => 'eventos#evento_players', as: 'eventoPlayers'
  # asistencias#new not required because Asistencia.new is called at
  # eventos#evento_players
  # get '/asistencias/new', to: 'asistencias#new'
  post '/asistencias', to: 'asistencias#create'
end
