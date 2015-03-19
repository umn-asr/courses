class Section < ::ActiveRecord::Base
  belongs_to :course
  belongs_to :instruction_mode
  belongs_to :grading_basis
  has_many :instructors

  validates_presence_of :class_number, :number, :component, :course_id

  attr_accessor :meeting_patterns, :combined_sections

  def type
    "section"
  end
end
