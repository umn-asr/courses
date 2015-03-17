class AddGradingBasisIdToSection < ActiveRecord::Migration
  def change
    add_belongs_to(:sections, :grading_basis)
  end
end
