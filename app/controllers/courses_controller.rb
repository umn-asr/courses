require_relative "../../lib/course_contract_tests/lib/reference_test"

class CoursesController < ApplicationController
  def index

    @campus = Campus.where(abbreviation: params[:campus_id].upcase).first
    @term = Term.where(strm: params[:term_id]).first

    f = File.open('tmp/course.json')

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
