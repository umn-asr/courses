class QueryableCourse
  attr_accessor :course, :subject_id, :catalog_number, :course_attribute_family, :course_attribute_id, :instruction_mode_id, :locations, :location_id

  def initialize(full_course)
    self.course = OpenStruct.new(id: full_course.id)
    self.subject_id = full_course.subject.subject_id
    self.catalog_number = full_course.catalog_number
    self.course_attribute_family = (full_course.course_attributes.collect { |a| a.family }).to_set
    self.course_attribute_id = (full_course.course_attributes.collect { |a| a.attribute_id }).to_set
    self.instruction_mode_id = (full_course.sections.collect { |s| s.instruction_mode }.compact.collect { |im| im.instruction_mode_id}).to_set
    self.locations = (full_course.sections.collect { |s| s.location}).to_set
    self.location_ids = Set.new

    full_course.sections.each do |section|
      section.meeting_patterns.each do |pattern|
        location_ids.add(pattern.location.location_id)
      end
    end
  end
end
