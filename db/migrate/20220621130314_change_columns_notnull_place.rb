class ChangeColumnsNotnullPlace < ActiveRecord::Migration[6.1]
  def change
    change_column_null :places, :latitude, true
    change_column_null :places, :longitude, true
  end
end
