class AddRepeatableFields < ActiveRecord::Migration
  def change
    add_column(:courses, :repeatable, :string)
    add_column(:courses, :units_repeat_limit, :string)
    add_column(:courses, :repeat_limit, :string)
  end
end
