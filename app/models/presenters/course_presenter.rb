class CoursePresenter
  extend Forwardable
  def_delegators :course, :type, :course_id, :id, :catalog_number, :description, :title
  attr_accessor :course, :course_attributes, :equivalency, :subject, :sections

  def initialize(ar_course)
    self.course = ar_course
    self.subject = ar_course.subject
    self.equivalency = ar_course.equivalency
    self.course_attributes = course.course_attributes.map { |s| CourseAttributePresenter.new(s) }
    self.sections = course.sections.map { |s| SectionPresenter.new(s) }
  end

  def cache_key
    course.id
  end

  def queryable
    x = OpenStruct.new
    x.cache_key = cache_key
    x.subject_id = subject_id
    x.catalog_number = course.catalog_number
    x.course_attribute_family = course_attribute_family
    x.course_attribute_id  = course_attribute_id
    x.instruction_mode_id  = instruction_mode_id
    x.locations  = locations
    x
  end

  def course_attribute_family
    @course_attribute_families ||= (course_attributes.collect { |a| a.family }).to_set
  end

  def course_attribute_id
    @course_attribute_ids ||= (course_attributes.collect { |a| a.attribute_id }).to_set
  end

  def subject_id
    @subject_id ||= subject.subject_id
  end

  def instruction_mode_id
    @instruction_modes ||= (sections.collect { |s| s.instruction_mode.instruction_mode_id}).to_set
  end

  def locations
    @locations ||= (sections.collect { |s| s.location}).to_set
  end
end
