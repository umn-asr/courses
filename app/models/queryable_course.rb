class QueryableCourse
  attr_accessor :course, :subject_id, :catalog_number, :course_attribute_family, :course_attribute_id, :instruction_mode_id, :locations

  def self.read(key, cache = Rails.cache)
    cache.read(key)
  end

  def self.build(full_course, cache = Rails.cache)
    x = self.new
    x.course = OpenStruct.new(cache_key: full_course.cache_key, id: full_course.id)
    x.subject_id = full_course.subject.subject_id
    x.catalog_number = full_course.catalog_number
    x.course_attribute_family = (full_course.course_attributes.collect { |a| a.family }).to_set
    x.course_attribute_id = (full_course.course_attributes.collect { |a| a.attribute_id }).to_set
    x.instruction_mode_id = (full_course.sections.collect { |s| s.instruction_mode.instruction_mode_id}).to_set
    x.locations = (full_course.sections.collect { |s| s.location}).to_set
    cache.fetch(x.cache_key) { x }
    x
  end

  def cache_key
    "#{course.cache_key}_queryable"
  end
end
