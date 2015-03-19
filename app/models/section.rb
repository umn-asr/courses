class Section < ::ActiveRecord::Base
  belongs_to :course
  belongs_to :instruction_mode

  validates_presence_of :class_number, :number, :component, :course_id

  attr_accessor :grading_basis, :instructors, :meeting_patterns, :combined_sections

  def type
    "section"
  end
end
