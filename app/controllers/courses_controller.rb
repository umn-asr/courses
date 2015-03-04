require_relative "../../lib/course_contract_tests/lib/reference_test"

class CoursesController < ApplicationController
  before_action :init_campus

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
      parsed = JSON.parse(params[:course].to_json)
      @campus.abbreviation = parsed["campus"]["abbreviation"]
      @campus_repo.save(@campus)
      render nothing: true
    end
  end

  private
  def init_campus
    @campus_repo = Repositories::CampusRepository.new
    @campus = @campus_repo.build
  end
end
