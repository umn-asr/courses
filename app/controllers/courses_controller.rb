require_relative "../../lib/course_contract_tests/lib/reference_test"

class CoursesController < ApplicationController
  def index
    campus_repo = Repositories::CampusRepository.new
    term_repo = Repositories::TermRepository.new

    @campus = campus_repo.find(params[:campus_id])
    @term = term_repo.find(params[:term_id])

    @courses = [OpenStruct.new(type: "course", id: "1", catalog_number: "12345")]

    render
  end

  def create
    begin
      ReferenceTest.test_structure(params[:course])
    rescue
      render nothing: true, status: 400
    else
      campus_repo = Repositories::CampusRepository.new
      campus_attr = params[:course]["campus"].permit(:abbreviation, :type, :id)
      campus_repo.save(campus_repo.build(attributes: campus_attr))

      term_repo = Repositories::TermRepository.new
      term_attr = params[:course]["term"].permit(:strm, :type, :id)
      term_repo.save(term_repo.build(attributes: term_attr))

      render nothing: true
    end
  end
end
