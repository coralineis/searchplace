class CreatePlaceGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :place_genres do |t|
      
      t.string :place_genre_name

      t.timestamps
    end
  end
end
