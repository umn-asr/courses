class CreateInstructorContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :instructor_contacts do |t|
      t.string :name
      t.string :email
    end
  end
end
