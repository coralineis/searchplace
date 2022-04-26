class CreateShopGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :shop_genres do |t|
      
      t.string :shop_genre_name

      t.timestamps
    end
  end
end
