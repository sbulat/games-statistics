class CreateTitles < ActiveRecord::Migration[5.0]
  def change
    create_table :titles do |t|
      t.string :name
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
