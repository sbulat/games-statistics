class HomeController < ApplicationController
  def index
    return unless current_user
    @favorites = current_user.favorites
    @games = current_user.games.order(played_at: :desc).first(5)
  end
end
