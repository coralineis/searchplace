class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|

      t.references :user, foreign_key: true
      t.references :plan, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
