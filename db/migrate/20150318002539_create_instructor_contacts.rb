class CreateInstructorContacts < ActiveRecord::Migration
  def change
    create_table :instructor_contacts do |t|
      t.string :name
      t.string :email
    end
  end
end
