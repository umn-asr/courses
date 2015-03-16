class Section < ::ActiveRecord::Base
  belongs_to :course

  validates_presence_of :class_number, :number, :component

  attr_accessor :instruction_mode, :grading_basis, :instructors, :meeting_patterns, :combined_sections

  def type
    "section"
  end
end
