class SearchableCourses
  extend Forwardable
  def_delegators :all_courses, :each, :select

  attr_accessor :all_courses

  def initialize(all_courses)
    self.all_courses = all_courses.map {|c| SearchableCourse.new(c) }
  end

  def self.find(campus, term)
    cached = Rails.cache.fetch("#{campus.id}_#{term.id}/all_courses")

    unless cached
      cached = Course.includes(:subject, :course_attributes, :sections => [:instruction_mode]).for_campus_and_term(campus, term).all.load
      Rails.cache.write(
        "#{campus.id}_#{term.id}/all_courses",
        cached
      )
    end

    self.new(cached)
  end
end


class SearchableCourse < SimpleDelegator
  def initialize(course)
    super(course)
  end

  def subject_id
    @subject ||= course.subject.subject_id
  end

  def course_attribute_family
    @course_attribute_families ||= (course.course_attributes.collect { |a| a.family }).to_set
  end

  def course_attribute_id
    @course_attribute_ids ||= (course.course_attributes.collect { |a| a.attribute_id }).to_set
  end

  def instruction_mode_id
    @instruction_modes ||= (course.sections.collect { |s| s.instruction_mode.instruction_mode_id}).to_set
  end

  def locations
    @locations ||= (course.sections.collect { |s| s.location}).to_set
  end

  def course
    __getobj__
  end
end
