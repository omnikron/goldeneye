Rails.application.routes.draw do
  resources :scores
  resources :weapon_sets
  resources :players
  resources :games

  root to: 'games#index'
end
