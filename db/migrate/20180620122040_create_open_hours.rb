class CreateOpenHours < ActiveRecord::Migration[5.2]
  def change
    create_table :open_hours do |t|
      t.references :restaurant
      t.integer :weekday
      t.string :open_at
      t.string :close_at

      t.timestamps
    end
  end
end
