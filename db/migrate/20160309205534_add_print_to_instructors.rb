class AddPrintToInstructors < ActiveRecord::Migration[5.2]
  def change
    add_column :instructors, :print, :string
  end
end
