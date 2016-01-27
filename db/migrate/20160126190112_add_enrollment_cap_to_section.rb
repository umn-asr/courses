class AddEnrollmentCapToSection < ActiveRecord::Migration
  def change
    add_column :sections, :enrollment_cap, :string
  end
end
