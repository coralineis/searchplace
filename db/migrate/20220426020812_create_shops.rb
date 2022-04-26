class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
       t.integer :user_id
       t.integer :like_id
       t.integer :review_id
       t.integer :shop_genre_id
       t.string :shop_name
       t.string :shop_image_id
       t.string :time
       t.text :introduction
       t.string :tag

      t.timestamps
    end
  end
end
