class AddPrintToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :print, :string
  end
end
