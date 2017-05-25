module HomeHelper
  def favorites_chart(favorites)
    favorites.inject([]) { |res, f| res.push([f.title.name, f.played_games]) }
  end
end
