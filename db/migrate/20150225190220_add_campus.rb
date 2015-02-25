class AddCampus < ActiveRecord::Migration
  def change
    create_table :campuses do |t|
      t.string :abbreviation
    end
  end
end
