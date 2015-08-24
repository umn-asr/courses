class InstructionMode < ::ActiveRecord::Base
  has_many :sections

  validates_presence_of :instruction_mode_id
  validates_uniqueness_of :instruction_mode_id

  def type
    "instruction_mode"
  end

  def to_h
    {
      type: type,
      instruction_mode_id: instruction_mode_id,
      id: id.to_s,
      description: description
    }
  end
end
