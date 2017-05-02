class AddPlayedAtToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :played_at, :datetime
  end
end
