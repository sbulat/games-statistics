module HomeHelper
  def favorites_chart(favorites)
    res = []

    favorites.each do |fav|
      res.push([fav.title.name, fav.title.user_played_games(current_user)])
    end

    res
  end
end
