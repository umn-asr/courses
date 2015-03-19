class CreateInstructorRoles < ActiveRecord::Migration
  def change
    create_table :instructor_roles do |t|
      t.string :abbreviation
    end
  end
end
