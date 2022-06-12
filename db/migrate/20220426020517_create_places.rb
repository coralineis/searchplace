class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|

      t.integer :user_id
      t.integer :place_genre_id
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :image
      t.string :time
      t.text :introduction

      t.timestamps
    end
  end
end
