class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :title_id
      t.integer :plays, default: 0

      t.timestamps
    end
  end
end
