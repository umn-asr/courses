class CreateInstructionModes < ActiveRecord::Migration
  def change
    create_table :instruction_modes do |t|
      t.string :instruction_mode_id
      t.string :description
    end
  end
end
