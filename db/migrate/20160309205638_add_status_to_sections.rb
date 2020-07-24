class AddStatusToSections < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :status, :string
  end
end
