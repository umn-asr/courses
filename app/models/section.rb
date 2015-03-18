class Section < ::ActiveRecord::Base
  belongs_to :course
  belongs_to :instruction_mode
  belongs_to :grading_basis
  has_many :instructors
  has_many :meeting_patterns, -> { order "start_date" }
  has_many :combined_sections

  validates_presence_of :class_number, :number, :component, :course_id

  def type
    "section"
  end
end
