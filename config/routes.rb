Rails.application.routes.draw do
  resources :notes

  resources :maps

  resources :scores
  resources :weapon_sets
  resources :players
  resources :games do
    collection do
      get :top_combinations
    end
  end

  root to: 'games#index'
end
