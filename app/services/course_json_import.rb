class CourseJsonImport
  def initialize(json)
    self.json = json
  end

  def course_json_invalid?(course_json)
    course_json["course_id"].blank? ||
      course_json["title"].blank? ||
      course_json["subject"].blank?
  end

  def run
    campus = Campus.where(abbreviation: json["campus"]["abbreviation"]).first
    term = Term.where(strm: json["term"]["strm"]).first

    json["courses"].each do |course_json|
      if course_json_invalid?(course_json)
        next
      end

      course_attr = {}
      course_attr = course_json.slice("title", "description", "course_id", "catalog_number", "repeatable", "repeat_limit", "units_repeat_limit", "offer_frequency", "credits_minimum", "credits_maximum")

      subject = Subject.find_or_create_by(course_json["subject"].slice("subject_id", "description").merge("term_id" => term.id, "campus_id" => campus.id))
      course_attr[:subject_id] = subject.id

      equivalency = parse_resource(Equivalency, course_json["equivalency"], {"equivalency_id" => "equivalency_id"})
      if equivalency
        course_attr[:equivalency_id] = equivalency.id
      end

      course = Course.create(course_attr)

      attributes = course_json["course_attributes"].map { |a| CourseAttribute.find_by(attribute_id: a["attribute_id"], family: a["family"]) }
      course.course_attributes = attributes
      course.grading_basis = parse_resource(GradingBasis, course_json["grading_basis"], {"grading_basis_id" => "grading_basis_id", "description" => "description"})

      course_json["sections"].map do |section_json|
        section = course.sections.build(section_json.slice("class_number", "number", "component", "location", "notes", "status", "print", "enrollment_cap"))
        section.instruction_mode = parse_resource(InstructionMode, section_json["instruction_mode"], {"instruction_mode_id" => "instruction_mode_id", "description" => "description"})
        section.save

        section_json["instructors"].each do |instructor_json|
          role = parse_resource(InstructorRole, instructor_json, {"role" => "abbreviation"})
          contact = parse_resource(InstructorContact, instructor_json, {"name" => "name", "email" => "email"})
          section.instructors.create(instructor_role: role, instructor_contact: contact, print: instructor_json["print"])
        end

        section_json["meeting_patterns"].each do |pattern_json|
          location = parse_resource(Location, pattern_json["location"], {"location_id" => "location_id", "description" => "description"})
          mp = section.meeting_patterns.create(start_time: pattern_json["start_time"], end_time: pattern_json["end_time"], start_date: pattern_json["start_date"], end_date: pattern_json["end_date"], location: location)

          pattern_json["days"].each do |day|
            mp.days << Day.find_by_abbreviation(day["abbreviation"])
          end
        end

        section_json["combined_sections"].each do |cs_json|
          section.combined_sections.create(cs_json.slice("catalog_number", "subject_id", "section_number"))
        end
      end

      course.save
    end
  end

  private

  attr_accessor :json

  def parse_resource(resource_class, json_node, attribute_mapping)
    if json_node.present?
      attributes = attribute_mapping.each_with_object({}) do |(json_key, attr_name), hash|
        hash[attr_name] = json_node[json_key]
      end
      resource_class.find_or_create_by(attributes)
    end
  end
end
