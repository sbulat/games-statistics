module TitlesHelper
  def overall_favs(title_id)
    Favorite.where(title_id: title_id).count
  end

  def score_type_select
    options_for_select([['Bramki', :goals], ['Punkty', :points]])
  end

  def titles_favorites_chart(titles)
    titles.inject([]) { |res, t| res.push([t.name, t.favorites.count]) }
  end

  def titles_played_chart(titles)
    titles.inject([]) { |res, t| res.push([t.name, t.games.count]) }
  end

  def title_wins_chart(games)
    res = {}

    games.each do |game|
      res[game.user_result] ||= 0
      res[game.user_result] += 1
    end

    res.map { |k, v| [k, v] }
  end

  def title_players_chart(games)
    res = {}

    games.each do |game|
      game.score.keys.each do |player|
        res[player] ||= 0
        res[player] += 1
      end
    end

    res.map { |k, v| [k, v] }
  end

  def title_score_chart(games)
    res = {}

    games.each do |game|
      game.score.each do |player, score|
        res[player] ||= 0
        res[player] += score.to_i
      end
    end

    arr = res.map { |k, v| [k, v] }
    arr.unshift(%w[Gracz Punkty/Bramki])
    arr
  end
end
