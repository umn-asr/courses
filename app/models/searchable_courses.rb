class SearchableCourses
  extend Forwardable
  def_delegators :all_courses, :each, :select

  attr_accessor :all_courses

  def initialize(all_courses)
    self.all_courses = all_courses.map {|c| SearchableCourse.new(c) }
  end
end


class SearchableCourse < SimpleDelegator
  def subject_id
    @subject ||= course.subject.subject_id
  end

  def cle_attribute_id
    @cle_attributes ||= (course.cle_attributes.collect { |a| a.attribute_id }).to_set
  end


  def instruction_mode_id
    @instruction_modes ||= (course.sections.collect { |s| s.instruction_mode.instruction_mode_id}).to_set
  end

  def course
    __getobj__
  end
end