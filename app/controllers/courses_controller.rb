class CoursesController < ApplicationController
  def index
    campus = Campus.where(abbreviation: params[:campus_id].upcase).first
    term = Term.where(strm: params[:term_id]).first

    f = File.open('test/fixtures/courses_example.json')

    j = JSON.parse(f.read)

    courses = Course.where(campus_id: campus.id, term_id: term.id)

    courses.each do |c|
      json_course = j["courses"].detect{ |x| x["course_id"] == c.course_id }

      c.subject = OpenStruct.new(json_course["subject"])

      c.sections.each do |s|
        json_section = json_course["sections"].detect{ |x| x["number"] == s.number }

        s.instruction_mode = OpenStruct.new(json_section["instruction_mode"])
        s.grading_basis = OpenStruct.new(json_section["grading_basis"])
        s.instructors = json_section["instructors"].map { |x| OpenStruct.new(x) }
        s.meeting_patterns = json_section["meeting_patterns"].map { |x| OpenStruct.new(x) }

        s.meeting_patterns.each do |m|
          m.location = OpenStruct.new(m.location)
          m.days.map! { |d| OpenStruct.new(d) }
        end

        s.combined_sections = json_section["combined_sections"].map { |x| OpenStruct.new(x) }
        s.combined_sections.each do |cs|
          cs.subject = OpenStruct.new(cs.subject)
          cs.section = OpenStruct.new(cs.section)
        end
      end
    end

    searchable_courses = SearchableCourses.new(courses)

    query_string_search = params[:q]
    returned_courses = QueryStringSearch.new(searchable_courses, query_string_search).results

    @courses = CoursesPresenter.new
    @courses.campus = campus
    @courses.term = term
    @courses.courses = returned_courses

    respond_to do |format|
      format.xml
      format.json
    end
  end

  def create
    begin
      campus_attr = params[:course]["campus"].permit(:abbreviation)
      campus = Campus.new(campus_attr)
      campus.save

      term_attr = params[:course]["term"].permit(:strm)
      term = Term.new(term_attr)
      term.save

      params[:course]["courses"].each do |course_data|
        course_attr = course_data.permit(:id, :course_id, :catalog_number, :description, :title, :subject, :sections)

        course_attr[:campus_id] = campus.id

        course_attr[:term_id] = term.id

        course = Course.new(course_attr)

        course.course_attributes = course_data["cle_attributes"].each_with_object([]) do |attribute, ret|
          ret << CourseAttribute.find_or_create_by(attribute_id: attribute["attribute_id"], family: attribute["family"])
        end

        course.save
      end

      render nothing: true
    rescue
      render nothing: true, status: 400
    end
  end
end
