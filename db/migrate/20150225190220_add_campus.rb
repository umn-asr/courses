class AddCampus < ActiveRecord::Migration
  def change
    create_table :campuses do |t|
      t.string :abbreviation
    end
    add_index :campuses, :abbreviation, :unique => true
  end
end
