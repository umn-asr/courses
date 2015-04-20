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
    course.cache_key
  end

  def self.fetch(course, cache = Rails.cache)
    cache.fetch(course.cache_key) do
      self.new(Course.find(course.id))
    end
  end
end
