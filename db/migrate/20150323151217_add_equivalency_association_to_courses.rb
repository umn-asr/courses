class AddEquivalencyAssociationToCourses < ActiveRecord::Migration[5.2]
  def change
    change_table :courses do |t|
      t.belongs_to :equivalency, index: true
    end
  end
end
