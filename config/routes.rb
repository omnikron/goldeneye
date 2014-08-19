Rails.application.routes.draw do
  resources :notes

  resources :maps

  resources :scores
  resources :weapon_sets
  resources :players
  resources :games

  root to: 'games#index'
end
