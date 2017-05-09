class HomeController < ApplicationController
  def index
    return unless current_user
    @favorites = current_user.favorites.joins(:title).order('titles.name')
    @games = current_user.games.order(played_at: :desc).first(5)
  end
end
