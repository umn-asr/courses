class Section < ::ActiveRecord::Base
  belongs_to :course
  belongs_to :instruction_mode
  belongs_to :grading_basis
  has_many :instructors
  has_many :meeting_patterns, -> { order "start_date" }

  validates_presence_of :class_number, :number, :component, :course_id

  attr_accessor :combined_sections

  def type
    "section"
  end
end
