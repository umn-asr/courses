require_relative "../../lib/course_contract_tests/lib/reference_test"

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
      ReferenceTest.test_structure(params[:course])
    rescue
      render nothing: true, status: 400
    else
      campus_attr = params[:course]["campus"].permit(:abbreviation, :type, :id)
      Campus.new(campus_attr).save

      term_attr = params[:course]["term"].permit(:strm, :type, :id)
      Term.new(term_attr).save

      render nothing: true
    end
  end
end
