module TitlesHelper
  def overall_favs(title_id)
    Favorite.where(title_id: title_id).count
  end
end
