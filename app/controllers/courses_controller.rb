class CoursesController < ApplicationController
  def index
    expires_in(8.hours, :public => true)
    Rails.logger.tagged("Ian") { Rails.logger.debug "######################New Request" }

    campus = Campus.where(abbreviation: params[:campus_id].upcase).first
    term = Term.where(strm: params[:term_id]).first

    x = Time.now.to_i
    Rails.logger.tagged("Ian") { Rails.logger.debug "Start course find" }
    courses = Course.for_campus_and_term(campus, term)
    Rails.logger.tagged("Ian") { Rails.logger.debug "End course find: #{Time.now.to_i - x}" }

    Rails.logger.tagged("Ian") { Rails.logger.debug "Start searchable course " }
    searchable_courses = SearchableCourses.new(courses)
    Rails.logger.tagged("Ian") { Rails.logger.debug "End searchable course: #{Time.now.to_i - x} " }

    Rails.logger.tagged("Ian") { Rails.logger.debug "Start filter course " }
    query_string_search = params[:q]
    returned_courses = QueryStringSearch.new(searchable_courses, query_string_search).results
    Rails.logger.tagged("Ian") { Rails.logger.debug "End filter course: #{Time.now.to_i - x} " }

    @courses = CoursesPresenter.new
    @courses.campus = campus
    @courses.term = term
    @courses.courses = returned_courses

    Rails.logger.tagged("Ian") { Rails.logger.debug "Start render course " }
    respond_to do |format|
      format.xml
      format.json
    end
    Rails.logger.tagged("Ian") { Rails.logger.debug "Finish render course: #{Time.now.to_i - x} " }
  end

  def create
    begin
      campus_attr = params[:course]["campus"].permit(:abbreviation)
      campus = Campus.find_or_create_by(campus_attr)

      term_attr = params[:course]["term"].permit(:strm)
      term = Term.find_or_create_by(term_attr)

      params[:course]["courses"].each do |course_data|
        course_attr = course_data.permit(:id, :course_id, :catalog_number, :description, :title, :sections)

        course_attr[:campus_id] = campus.id

        course_attr[:term_id] = term.id

        course = Course.new(course_attr)

        course.subject = Subject.find_or_create_by(subject_id: course_data["subject"]["subject_id"], description: course_data["subject"]["description"])

        course.course_attributes = course_data["cle_attributes"].each_with_object([]) do |attribute, ret|
          ret << CourseAttribute.find_or_create_by(attribute_id: attribute["attribute_id"], family: attribute["family"])
        end

        equivalency_data = course_data["equivalency"]
        if equivalency_data
          course.equivalency = Equivalency.find_or_create_by(equivalency_id: equivalency_data["equivalency_id"])
        end

        course.save

        course_data["sections"].each do |section_data|
          section_attr = section_data.permit(:class_number, :number, :component, :credits_minimum, :credits_maximum, :location, :notes, :instruction_mode)
          section = course.sections.find_or_create_by(section_attr.slice("class_number", "number"))
          section.update_attributes(section_attr.slice("component", "credits_minimum", "credits_maximum", "location", "notes"))

          instruction_mode_attr = section_data[:instruction_mode].permit(:instruction_mode_id, :description)
          section.instruction_mode = InstructionMode.find_or_create_by(instruction_mode_attr)

          grading_basis_attr = section_data[:grading_basis].permit(:grading_basis_id, :description)
          section.grading_basis = GradingBasis.find_or_create_by(grading_basis_attr)

          section.save

          section_data[:instructors].each do |instructor_data|
            role = InstructorRole.find_or_create_by(abbreviation: instructor_data[:role])
            contact_attr = instructor_data.permit(:name, :email)
            contact = InstructorContact.find_or_create_by(contact_attr)
            section.instructors.create(instructor_role: role, instructor_contact: contact)
          end

          section_data[:meeting_patterns].each do |pattern_data|
            mp_attr = pattern_data.permit(:start_time, :end_time, :start_date, :end_date)
            mp = section.meeting_patterns.find_or_create_by(mp_attr)

            location_data = pattern_data[:location]
            if location_data
              mp.location = Location.find_or_create_by(location_data.permit(:location_id, :description))
            end

            pattern_data[:days].each do |day|
              day_attr = day.permit(:abbreviation, :name)
              mp.days << Day.find_or_create_by(day_attr)
            end

            mp.save
          end

          Array(section_data[:combined_sections]).each do |cs_data|
            cs_attr = cs_data.permit(:catalog_number, :subject_id, :section_number)
            section.combined_sections.create(cs_attr)
          end
        end
      end

      render nothing: true
    rescue
      render nothing: true, status: 400
    end
  end
end
