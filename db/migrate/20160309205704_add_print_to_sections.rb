class AddPrintToSections < ActiveRecord::Migration
  def change
    add_column :sections, :print, :string
  end
end
