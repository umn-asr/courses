class SectionPresenter
  extend Forwardable
  def_delegators :section, :id, :class_number, :number, :component, :location, :credits_maximum, :credits_minimum, :notes

  attr_accessor :section, :instruction_mode, :grading_basis, :instructors, :meeting_patterns, :combined_sections

  def initialize(ar_section)
    self.section = ar_section
    self.instruction_mode = ar_section.instruction_mode
    self.grading_basis = ar_section.grading_basis
    self.instructors = ar_section.instructors.map { |i| InstructorPresenter.new(i) }
    self.meeting_patterns = ar_section.meeting_patterns.map { |i| MeetingPatternPresenter.new(i) }
    self.combined_sections = ar_section.combined_sections.map { |cs| CombinedSectionPresenter.new(cs) }
  end

  def cache_key
    section.id
  end
end
