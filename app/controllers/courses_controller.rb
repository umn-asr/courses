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
      c.cle_attributes = json_course["cle_attributes"].map { |x| OpenStruct.new(x) }

      c.sections = json_course["sections"].map { |x| OpenStruct.new(x) }

      c.sections.each do |s|
        s.instruction_mode = OpenStruct.new(s.instruction_mode)
        s.grading_basis = OpenStruct.new(s.grading_basis)
        s.instructors.map! { |i| OpenStruct.new(i) }

        s.meeting_patterns.map! { |m| OpenStruct.new(m) }

        s.meeting_patterns.each do |m|
          m.location = OpenStruct.new(m.location)
          m.days.map! { |d| OpenStruct.new(d) }
        end

        s.combined_sections.map! { |x| OpenStruct.new(x) }
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


      params[:course]["courses"].each do |course|
        course_attr = course.permit(:id, :course_id, :catalog_number, :description, :title, :subject, :cle_attributes, :sections)

        course_attr[:campus_id] = campus.id

        course_attr[:term_id] = term.id

        course = Course.new(course_attr)
        course.save
      end

      render nothing: true
    rescue
      render nothing: true, status: 400
    end
  end
end
