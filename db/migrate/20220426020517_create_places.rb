class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|

      t.integer :user_id, null: false
      t.integer :place_genre_id, null: false
      t.integer :prefecture, null: false
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :image, null: false
      t.string :time, null: false
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
