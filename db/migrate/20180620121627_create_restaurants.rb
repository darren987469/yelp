class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.bigint :fid
      t.string :name

      t.timestamps
    end

    add_index :restaurants, :fid
  end
end
