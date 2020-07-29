class MoveCreditAttributesToCourse < ActiveRecord::Migration[5.2]
  def change
    remove_column(:sections, :credits_minimum)
    remove_column(:sections, :credits_maximum)
    add_column(:courses, :credits_minimum, :string)
    add_column(:courses, :credits_maximum, :string)
  end
end
