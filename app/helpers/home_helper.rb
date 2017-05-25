module HomeHelper
  def favorites_chart(favorites)
    res = []

    favorites.each do |fav|
      res.push([fav.title.name, fav.played_games])
    end

    res
  end
end
