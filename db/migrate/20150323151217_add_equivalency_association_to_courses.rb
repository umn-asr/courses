class AddEquivalencyAssociationToCourses < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.belongs_to :equivalency, index: true
    end
  end
end
