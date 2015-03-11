class CoursesController < ApplicationController
  def index
    campus = Campus.where(abbreviation: params[:campus_id].upcase).first
    term = Term.where(strm: params[:term_id]).first

    f = File.open('test/fixtures/courses_example.json')

    j = JSON.parse(f.read)

    courses = j["courses"].map { |x| OpenStruct.new(x) }

    courses.each do |c|
      c.subject = OpenStruct.new(c.subject)
      c.cle_attributes.map! { |x| OpenStruct.new(x) }
      c.sections.map! { |x| OpenStruct.new(x) }

      c.sections.each do |s|
        s.instruction_mode = OpenStruct.new(s.instruction_mode)
        s.grading_basis = OpenStruct.new(s.grading_basis)
        s.instructors.map! { |i| OpenStruct.new(i) }
        s.meeting_patterns.map! { |m| OpenStruct.new(m) }

        s.meeting_patterns.each do |m|
          m.location = OpenStruct.new(m.location)
        end

        s.combined_sections.map! { |x| OpenStruct.new(x) }
        s.combined_sections.each do |cs|
          cs.subject = OpenStruct.new(cs.subject)
          cs.section = OpenStruct.new(cs.section)
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
      campus_attr = params[:course]["campus"].permit(:abbreviation, :type)
      resources = []
      resources << Campus.new(campus_attr)

      term_attr = params[:course]["term"].permit(:strm, :type)
      resources << Term.new(term_attr)

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
