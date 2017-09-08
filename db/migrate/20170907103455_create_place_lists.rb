class CreatePlaceLists < ActiveRecord::Migration[5.0]
  def change
    create_table :place_lists do |t|
      t.integer :lat
      t.integer :lng
      t.integer :radian
      t.integer :category
      t.timestamps
    end
  end
end
