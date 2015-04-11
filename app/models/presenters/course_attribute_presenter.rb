class CourseAttributePresenter
  extend Forwardable
  def_delegators :course_attribute, :type, :attribute_id, :family
  attr_accessor :course_attribute

  def initialize(ar_attribute)
    self.course_attribute = ar_attribute
  end
end
