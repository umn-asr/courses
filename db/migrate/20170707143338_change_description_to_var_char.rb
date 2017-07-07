class ChangeDescriptionToVarChar < ActiveRecord::Migration[5.0]
  def change
    change_column :courses, :description, :string, limit: 4000
  end
end
