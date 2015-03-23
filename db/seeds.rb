# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Campus.delete_all
Term.delete_all
Course.delete_all
Subject.delete_all
CourseAttribute.delete_all
Section.delete_all
InstructionMode.delete_all
GradingBasis.delete_all
InstructorContact.delete_all
InstructorRole.delete_all
Instructor.delete_all
Day.delete_all
Location.delete_all
MeetingPattern.delete_all
CombinedSection.delete_all

%w(UMNTC UMNDL UMNMO UMNRC UMNRO).each do |abbreviation|
  Campus.create({abbreviation: abbreviation})
end

%w(1149 1155 1159 1163).each do |strm|
  Term.create({strm: strm})
end

%w(AH BIOL HIS LITR MATH PHYS SOCS GP TS CIV DSJ ENV WI).each do |attribute_id|
  CourseAttribute.create({attribute_id: attribute_id, family: "CLE"})
end

{"m" => "Monday", "t" => "Tuesday", "w" => "Wednesday", "th" => "Thursday", "f" => "Friday", "sa" => "Saturday", "su" => "Sunday"}.each do |abbreviation, name|
  Day.create(abbreviation: abbreviation, name: name)
end

%w(1149 1155 1159 1163).each do |strm|
  Term.create({strm: strm})
end

f = File.open('test/fixtures/courses_example.json')

j = JSON.parse(f.read)

j["courses"].each do |course_json|
  course_attr = Hash.new
  course_attr = course_json.slice("title", "description", "course_id", "catalog_number")

  campus = Campus.where(abbreviation: j["campus"]["abbreviation"]).first
  course_attr[:campus_id] = campus.id

  term = Term.where(strm: j["term"]["strm"]).first
  course_attr[:term_id] = term.id

  subject = Subject.find_or_create_by(course_json["subject"].slice("subject_id", "description"))
  course_attr[:subject_id] = subject.id

  equivalency_json = course_json["equivalency"]
  if equivalency_json
    equivalency = Equivalency.find_or_create_by(equivalency_json.slice("equivalency_id"))
    course_attr[:equivalency_id] = equivalency.id
  end

  @course = Course.create(course_attr)

  attributes = course_json["cle_attributes"].map { |a| CourseAttribute.where(attribute_id: a["attribute_id"]).first }
  @course.course_attributes = attributes

  course_json["sections"].map do |section_json|
    section = @course.sections.build(section_json.slice("class_number", "number", "component", "credits_minimum", "credits_maximum", "location", "notes"))
    section.instruction_mode = InstructionMode.find_or_create_by(section_json["instruction_mode"].slice("instruction_mode_id","description"))
    section.grading_basis = GradingBasis.find_or_create_by(section_json["grading_basis"].slice("grading_basis_id","description"))

    section.grading_basis = GradingBasis.find_or_create_by(section_json["grading_basis"].slice("grading_basis_id","description"))
    section.save

    section_json["instructors"].each do |instructor_json|
      role = InstructorRole.find_or_create_by(abbreviation: instructor_json["role"])
      contact = InstructorContact.find_or_create_by(instructor_json.slice("name","email"))
      section.instructors.create(instructor_role: role, instructor_contact: contact)
    end

    section_json["meeting_patterns"].each do |pattern_json|
      mp = section.meeting_patterns.create(pattern_json.slice("start_time","end_time","start_date","end_date"))

      location_json = pattern_json["location"]
      if location_json
        Location.find_or_create_by(location_json.slice("location_id","description"))
      end

      pattern_json["days"].each do |day|
        mp.days << Day.find_by_abbreviation(day["abbreviation"])
      end
      mp.save
    end

    section_json["combined_sections"].each do |cs_json|
      section.combined_sections.create(cs_json.slice("catalog_number", "subject_id", "section_number"))
    end
  end

  @course.save
end

