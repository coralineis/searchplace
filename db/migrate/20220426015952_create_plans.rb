class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|

      t.integer :user_id
      t.integer :like_id
      t.integer :review_id
      t.string :name
      t.string :place_name
      t.integer :time
      t.string :stay_night
      t.text :introduction
      t.json :images

      t.timestamps
    end
  end
end
