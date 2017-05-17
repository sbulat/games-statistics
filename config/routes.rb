Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  post '/title/:id/accept', to: 'titles#accept', as: 'accept_title'
  post '/title/:id/favorite', to: 'titles#favorite', as: 'favorite_title'
  resources :titles

  get '/games/player_row', to: 'games#player_row', as: 'games_player_row'
  resources :games, except: %i[edit update]

  root to: 'home#index'
end
