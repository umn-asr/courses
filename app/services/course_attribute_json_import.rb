class CourseAttributeJsonImport
  def initialize(json)
    self.json = json
  end

  def run
    course_attributes.each do |course_attribute|
      CourseAttribute.create(attribute_id: course_attribute["attribute_id"], family: course_attribute["family"])
    end
  end

  private

  attr_accessor :json

  def course_attributes
    json["courses"].map { |course| course["course_attributes"] }.flatten.compact.uniq
  end
end
