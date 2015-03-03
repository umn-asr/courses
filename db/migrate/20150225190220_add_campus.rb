class AddCampus < ActiveRecord::Migration
  def change
    create_table :campuses do |t|
      t.string :abbreviation, :unique => true
    end
    add_index :campuses, :abbreviation, :unique => true
  end
end
