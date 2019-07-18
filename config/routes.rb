Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'dev'

  get 'welcome/index'
  get 'welcome/notplayer'
  get 'welcome/update_teams', as: 'update_teams'
  get 'welcome/update_enemy', as: 'update_enemy'
  get 'application/adm_new_up', as: 'adm_new_up'
  get 'teams/appfortourn', as: 'appfortourn'
  post 'teams/creat_appfortourn', as: 'creat_appfortourn'
  patch 'chekins/failed', as: 'failed'
  delete 'players/destroy_together_user', as: 'destroy_together_user'

  resources :players
  resources :teams, only: [:show, :edit, :update, :index]
  resources :games
  resources :rosters
  resources :federations, only: [:show, :index]
  resources :tournaments, only: [:show, :index]
  resources :locations, only: [:show, :index]
  resources :chekins
  resources :events
  resources :player_teams
  resources :team_tournaments
  resources :user_roles
  resources :users, only: [:new,:create]

  resource :reason, only: [:show]
  resource :role, only: [:show]

  namespace :admin do
    resources :federations, except: [:show, :index]
    resources :locations, except: [:show, :index]
    resources :tournaments, except: [:show, :index]
    resources :teams, except: [:show, :index]
    # resources :users, except: [:index]
    resources :users
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
