Rails.application.routes.draw do
  devise_for :users

  get 'welcome/index'
  get 'welcome/notplayer'


  resources :players
  resources :teams, only: [:show, :edit]
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
    resources :users, except: [:index]
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
