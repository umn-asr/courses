class AddGradingBasisIdToSection < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to(:sections, :grading_basis)
  end
end
