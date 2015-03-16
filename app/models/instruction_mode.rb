class InstructionMode < ::ActiveRecord::Base
  has_many :sections

  validates_presence_of :instruction_mode_id
  validates_uniqueness_of :instruction_mode_id

  def type
    "instruction_mode"
  end
end
