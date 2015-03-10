class CoursesController < ApplicationController
  def index

    @campus = Campus.where(abbreviation: params[:campus_id].upcase).first
    @term = Term.where(strm: params[:term_id]).first

    f = File.open('test/fixtures/courses_example.json')

    j = JSON.parse(f.read)

    @courses = j["courses"].map { |x| OpenStruct.new(x) }

    render
  end

  def create
    begin
      campus_attr = params[:course]["campus"].permit(:abbreviation, :type, :id)
      resources = []
      resources << Campus.new(campus_attr)

      term_attr = params[:course]["term"].permit(:strm, :type, :id)
      resources << Term.new(term_attr)

      params[:course]["courses"].each do |course|
        course_attr = course.permit(:id, :course_id, :type, :catalog_number, :description, :title, :subject, :attributes, :sections)
        course_attr[:campus_id] = params[:course]["campus"][:id]
        course_attr[:term_id] = params[:course]["term"][:id]
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
