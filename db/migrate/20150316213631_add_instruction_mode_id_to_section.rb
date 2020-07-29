class AddInstructionModeIdToSection < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to(:sections, :instruction_mode)
  end
end
