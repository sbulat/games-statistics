class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :title_id
      t.text :score
      t.text :result
      t.text :additional_info

      t.timestamps
    end
  end
end
