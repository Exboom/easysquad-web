Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  get 'welcome/notplayer'


  resources :players
  resources :teams
  resources :games
  resources :applications
  resources :federations
  resources :tournaments
  resources :locations
  resources :chekins
  resources :events
  resources :player_teams
  resources :team_tournaments
  resources :user_roles

  resource :reason, only: [:show]
  resource :role, only: [:show]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
