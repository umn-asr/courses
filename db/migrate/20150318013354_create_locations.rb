class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_id
      t.string :description
    end
  end
end
