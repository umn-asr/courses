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
        s.instruction_mode = OpenStruct.new(Hash[s.instruction_mode.map { |key, value| [key, value] }])
        s.grading_basis = OpenStruct.new(Hash[s.grading_basis.map { |key, value| [key, value] }])

        s.instructors.each do
          s.instructors = s.instructors.map { |x| OpenStruct.new(x) }
        end

        s.meeting_patterns.each do |m|
          s.meeting_patterns = s.meeting_patterns.map { |x| OpenStruct.new(x) }
        end

        s.meeting_patterns.each do |m|
          m.location = OpenStruct.new(m.location)
        end
      end
    end

    @courses = CoursesPresenter.new
    @courses.campus = campus
    @courses.term = term
    @courses.courses = courses

    respond_to do |format|
      format.xml
      format.json
    end
  end

  def create
    begin
      campus_attr = params[:course]["campus"].permit(:abbreviation, :id)
      resources = []
      campus = Campus.new(campus_attr)
      resources << campus

      term_attr = params[:course]["term"].permit(:strm, :id)
      term = Term.new(term_attr)
      resources << term

      params[:course]["courses"].each do |course|
        course_attr = course.permit(:id, :course_id, :catalog_number, :description, :title, :subject, :cle_attributes, :sections)

        course_attr[:campus_id] = campus.id

        course_attr[:term_id] = term.id

        resources << Course.new(course_attr)
      end

      if resources.all? { |r| r.valid? && r.save }
        render nothing: true
      else
        render nothing: true, status: 400
      end
    rescue
      render nothing: true, status: 400
    end
  end
end
