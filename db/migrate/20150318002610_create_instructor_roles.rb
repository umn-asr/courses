class CreateInstructorRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :instructor_roles do |t|
      t.string :abbreviation
    end
  end
end
