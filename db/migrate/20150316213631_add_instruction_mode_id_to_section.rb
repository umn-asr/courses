class AddInstructionModeIdToSection < ActiveRecord::Migration
  def change
    add_belongs_to(:sections, :instruction_mode)
  end
end
