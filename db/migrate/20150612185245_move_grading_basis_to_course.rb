class MoveGradingBasisToCourse < ActiveRecord::Migration
  def change
    remove_belongs_to(:sections, :grading_basis, index: true)
    add_belongs_to(:courses, :grading_basis)
  end
end
