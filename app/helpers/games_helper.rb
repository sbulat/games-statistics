module GamesHelper
  def results_select
    options_for_select(%w[Wygrana Przegrana Remis])
  end

  def user_titles_played_chart(games)
    games.inject([]) do |memo, game|
      memo.push([game.title.name, game.title.user_played_games(current_user)])
    end
  end

  def user_results_chart(games)
    h = {}
    games.each do |game|
      h[game.user_result] ||= 0
      h[game.user_result] += 1
    end

    h.map { |k, v| [k, v] }
  end
end
