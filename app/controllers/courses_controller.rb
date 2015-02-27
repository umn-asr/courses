require_relative "../../lib/course_contract_tests/lib/reference_test"

class CoursesController < ApplicationController
  def index
    data = {
      campus: {
        type: "",
        id: "",
        abbreviation: ""
      },
      term: {
        type: "",
        id: "",
        strm: ""
      },
      courses: [
        {
          "type" => "",
          "id" => "",
          "catalog_number" => "",
        }
      ]
    }

    render json: data
  end

  def create
    begin
      ReferenceTest.test_structure(params[:course])
    rescue
      render nothing: true, status: 400
    else
      parsed = JSON.parse(params[:course].to_json)
      campus_repo = Repositories::CampusRepository.new
      campus = campus_repo.build
      campus.abbreviation = parsed["campus"]["abbreviation"]
      campus_repo.save(campus)
      render nothing: true
    end
  end
end
