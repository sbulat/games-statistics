Rails.application.routes.draw do
  devise_for :users

  resources :titles, only: %i[index new create]
  post '/title/:id/accept', to: 'titles#accept', as: 'accept_title'
  post '/title/:id/favorite', to: 'titles#favorite', as: 'favorite_title'

  resources :games, only: %i[index new create]
  get '/games/player_row', to: 'games#player_row', as: 'games_player_row'

  root to: 'home#index'
end