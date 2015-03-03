require "rails_helper"
require 'json'
require_relative "../../lib/course_contract_tests/lib/reference_test"

RSpec.describe "get courses" do
  describe "as json" do
    it "returns a structure that matches our reference structure " do
      get "/campuses/UMNTC/terms/1149/courses.json"

      parsed_response = JSON.parse(response.body)
      expect { ReferenceTest.test_structure(parsed_response) }.not_to raise_error
    end
  end
end
