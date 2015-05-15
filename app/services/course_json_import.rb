class CourseJsonImport
  def initialize(json)
    self.json = json
  end

  def run
    json["courses"].each do |course_json|
      course_attr = Hash.new
      course_attr = course_json.slice("title", "description", "course_id", "catalog_number")

      campus = Campus.where(abbreviation: json["campus"]["abbreviation"]).first

      term = Term.where(strm: json["term"]["strm"]).first

      subject = Subject.find_or_create_by(course_json["subject"].slice("subject_id", "description").merge({campus_id: campus.id, term_id: term.id}))
      course_attr[:subject_id] = subject.id

      equivalency = parse_resource(Equivalency, course_json["equivalency"], ["equivalency_id"])
      if equivalency
        course_attr[:equivalency_id] = equivalency.id
      end

      course = Course.create(course_attr)

      attributes = course_json["course_attributes"].map { |a| CourseAttribute.find_by(attribute_id: a["attribute_id"], family: a["family"]) }
      course.course_attributes = attributes

      course_json["sections"].map do |section_json|
        section = course.sections.build(section_json.slice("class_number", "number", "component", "credits_minimum", "credits_maximum", "location", "notes"))
        section.instruction_mode = parse_resource(InstructionMode, section_json["instruction_mode"], ["instruction_mode_id","description"])
        section.grading_basis = parse_resource(GradingBasis, section_json["grading_basis"], ["grading_basis_id","description"])
        section.save

        section_json["instructors"].each do |instructor_json|
          role = InstructorRole.find_or_create_by(abbreviation: instructor_json["role"])
          contact = parse_resource(InstructorContact, instructor_json, ["name","email"])
          section.instructors.create(instructor_role: role, instructor_contact: contact)
        end

        section_json["meeting_patterns"].each do |pattern_json|
          mp = section.meeting_patterns.create(pattern_json.slice("start_time","end_time","start_date","end_date"))

          mp.location = parse_resource(Location, pattern_json["location"], ["location_id","description"])

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

  def parse_resource(resource_class, json_node, attribute_keys)
    if json_node
      resource_class.find_or_create_by(json_node.slice(*attribute_keys))
    end
  end
end