class AddScoreTypeToTitles < ActiveRecord::Migration[5.0]
  def change
    add_column :titles, :score_type, :integer, default: 0
  end
end
