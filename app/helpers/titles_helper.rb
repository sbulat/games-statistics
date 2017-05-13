module TitlesHelper
  def overall_favs(title_id)
    Favorite.where(title_id: title_id).count
  end

  def score_type_select
    options_for_select([['Bramki', :goals], ['Punkty', :points]])
  end

  def titles_favorites_chart(titles)
    res = []

    titles.each do |title|
      res.push([title.name, title.favorites.count])
    end

    res
  end

  def titles_played_chart(titles)
    res = []

    titles.each do |title|
      res.push([title.name, title.games.count])
    end

    res
  end
end
