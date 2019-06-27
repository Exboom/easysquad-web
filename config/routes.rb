Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'dev'

  get 'welcome/index'
  get 'welcome/notplayer'
  get 'welcome/update_teams', as: 'update_teams'
  get 'welcome/update_enemy', as: 'update_enemy'
  get 'application/adm_new_up', as: 'adm_new_up'


  resources :players
  resources :teams, only: [:show, :edit, :update]
  resources :games
  resources :applications
  resources :federations, only: [:show]
  resources :tournaments, only: [:show]
  resources :locations, only: [:show]
  resources :chekins
  resources :events
  resources :player_teams
  resources :team_tournaments
  resources :user_roles

  resource :reason, only: [:show]
  resource :role, only: [:show]

  namespace :admin do
    resources :federations, except: [:show]
    resources :locations, except: [:show]
    resources :tournaments, except: [:show]
    resources :teams, except: [:show, :edit]
    # resources :users, except: [:index]
    resources :users
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
