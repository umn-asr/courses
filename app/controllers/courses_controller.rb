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
      test_structure(params[:course], reference_structure)
    rescue
      render nothing: true, status: 400
    else
      render nothing: true
    end
  end

  def test_structure(actual, reference)
    if actual.respond_to?(:keys) || reference.respond_to?(:keys)
      raise ArgumentError if !actual.respond_to?(:keys)
      raise ArgumentError if !reference.respond_to?(:keys)
      raise ArgumentError if actual.keys != reference.keys

      actual.keys.each do |k|
        test_structure(actual[k], reference[k])
      end
    elsif actual.respond_to?(:each) || actual.respond_to?(:each)
      raise ArgumentError if !actual.respond_to?(:each)
      raise ArgumentError if !reference.respond_to?(:each)

      test_structure(actual.sample, reference.sample)
    else
      #noop
    end
  end

  def reference_structure
    {
      "campus" => {
        "type" => "campus",
        "id" => "UMNTC",
        "abbreviation" => "UMNTC"
      },
      "term" => {
        "type" => "term",
        "id" => "1149",
        "strm" => "1149"
      },
      "courses" => [
        {
          "type" => "course",
          "id" => 1,
          "catalog_number" => "12345"
        },
      ]
    }
  end
end
