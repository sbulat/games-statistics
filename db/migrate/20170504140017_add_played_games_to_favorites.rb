class AddPlayedGamesToFavorites < ActiveRecord::Migration[5.0]
  def change
    add_column :favorites, :played_games, :integer, default: 0

    Favorite.all.each do |f|
      f.played_games = f.user.games.where(title_id: f.title_id).count
      f.save
    end
  end
end
