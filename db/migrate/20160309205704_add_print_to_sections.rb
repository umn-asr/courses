class AddPrintToSections < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :print, :string
  end
end
