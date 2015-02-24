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
end
