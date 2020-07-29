class CreateCombinedSections < ActiveRecord::Migration[5.2]
  def change
    create_table :combined_sections do |t|
      t.belongs_to :section
      t.string :catalog_number
      t.string :subject_id
      t.string :section_number
    end
  end
end
