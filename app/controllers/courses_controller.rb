require_relative "../../lib/reference_test"

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
      render nothing: true
    end
  end
end
