class QueryableCourse
  def self.read(key)
    Rails.cache.read(key)
  end

  def self.build(course)
    x = self.new(course)
    x.course
    x.subject_id
    x.catalog_number
    x.course_attribute_family
    x.course_attribute_id
    x.instruction_mode_id
    x.locations
    Rails.cache.fetch(x.cache_key) { x }
    x
  end

  def initialize(full_course)
    self.full_course = full_course
  end

  def cache_key
    "#{course.cache_key}_queryable"
  end

  def course
    OpenStruct.new(cache_key: full_course.cache_key, id: full_course.id)
  end

  def subject_id
    full_course.subject.subject_id
  end

  def catalog_number
    full_course.catalog_number
  end

  def course_attribute_family
    (full_course.course_attributes.collect { |a| a.family }).to_set
  end

  def course_attribute_id
    (full_course.course_attributes.collect { |a| a.attribute_id }).to_set
  end

  def instruction_mode_id
    (full_course.sections.collect { |s| s.instruction_mode.instruction_mode_id}).to_set
  end

  def locations
    (full_course.sections.collect { |s| s.location}).to_set
  end

  private

  attr_accessor :full_course
end
