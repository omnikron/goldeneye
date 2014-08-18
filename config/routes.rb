Rails.application.routes.draw do
  resources :maps

  resources :scores
  resources :weapon_sets
  resources :players
  resources :games

  root to: 'games#index'
end
