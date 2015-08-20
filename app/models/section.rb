class Section < ::ActiveRecord::Base
  belongs_to :course
  belongs_to :instruction_mode
  has_many :instructors
  has_many :meeting_patterns, -> { order "start_date" }
  has_many :combined_sections

  validates_presence_of :class_number, :number, :component, :course_id

  def type
    "section"
  end

  def enrollment
    Enrollment.fetch(self)
  end

  def to_h
    {
      type: type,
      id: id,
      class_number: class_number,
      number: number,
      component: component,
      location: location,
      notes: notes,
      instruction_mode: instruction_mode.to_h,
      instructors: instructors.map { |i| i.to_h },
      meeting_patterns: meeting_patterns.map { |mp| mp.to_h },
      combined_sections: combined_sections.map { |cs| cs.to_h },
      enrollment: enrollment.to_h
    }.delete_if { |_, value| value == {} }
  end
end
