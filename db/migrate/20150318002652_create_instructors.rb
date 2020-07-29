class CreateInstructors < ActiveRecord::Migration[5.2]
  def change
    create_table :instructors do |t|
      t.belongs_to :instructor_contact, index: true
      t.belongs_to :section, index: true
      t.belongs_to :instructor_role, index: true
    end
  end
end
