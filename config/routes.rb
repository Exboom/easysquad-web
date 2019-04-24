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



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
