module GamesHelper
  def results_select
    options_for_select(%w[Wygrana Przegrana Remis])
  end
end
