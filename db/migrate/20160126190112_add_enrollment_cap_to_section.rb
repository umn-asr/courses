class AddEnrollmentCapToSection < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :enrollment_cap, :string
  end
end
