module TitlesHelper
  def overall_favs(title_id)
    Favorite.where(title_id: title_id).count
  end

  def score_type_select
    options_for_select([['Bramki', :goals], ['Punkty', :points]])
  end
end
