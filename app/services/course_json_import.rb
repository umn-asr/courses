class CourseJsonImport
  def initialize(json)
    self.json = json
  end

  def run
    campus = Campus.where(abbreviation: json["campus"]["abbreviation"]).first
    term = Term.where(strm: json["term"]["strm"]).first

    json["courses"].each do |course_json|
      course_attr = Hash.new
      course_attr = course_json.slice("title", "description", "course_id", "catalog_number", "repeatable", "repeat_limit", "units_repeat_limit", "offer_frequency", "credits_minimum", "credits_maximum")

      subject = parse_resource(Subject, course_json["subject"], {"subject_id" => "subject_id", "description" => "description"})
      subject.update(campus_id: campus.id, term_id: term.id)
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
        section = course.sections.build(section_json.slice("class_number", "number", "component", "location", "notes"))
        section.instruction_mode = parse_resource(InstructionMode, section_json["instruction_mode"], {"instruction_mode_id" => "instruction_mode_id","description" => "description"})
        section.save

        section_json["instructors"].each do |instructor_json|
          role = parse_resource(InstructorRole, instructor_json, {"role" => "abbreviation"})
          contact = parse_resource(InstructorContact, instructor_json, {"name" => "name","email" => "email"})
          section.instructors.create(instructor_role: role, instructor_contact: contact)
        end

        section_json["meeting_patterns"].each do |pattern_json|
          mp = parse_resource(MeetingPattern, pattern_json, {"start_time" => "start_time","end_time" => "end_time","start_date" => "start_date","end_date" => "end_date"})
          mp.section_id = section.id
          mp.save

          mp.location = parse_resource(Location, pattern_json["location"], {"location_id" => "location_id","description" => "description"})

          pattern_json["days"].each do |day|
            mp.days << Day.find_by_abbreviation(day["abbreviation"])
          end
          mp.save
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
